package tech.igotech.ia;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.CookieManager;
import android.webkit.DownloadListener;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

/**
 * Application Android IgoTech IA.
 *
 * Affiche la plateforme web dans une WebView : mêmes comptes, même base de
 * données, mêmes contenus. Le jeton « IgoTechApp » ajouté au user-agent permet
 * au site de masquer la proposition de téléchargement dans l'application.
 */
public class MainActivity extends Activity {

    private static final int FILE_CHOOSER_REQUEST = 1;
    private static final String UA_TOKEN = " IgoTechApp/" + BuildInfo.VERSION_NAME;

    private WebView webView;
    private ProgressBar progressBar;
    private LinearLayout offlineView;
    private String appHost;
    private ValueCallback<Uri[]> fileCallback;
    private boolean mainFrameError;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        String appUrl = getString(R.string.app_url);
        appHost = Uri.parse(appUrl).getHost();

        FrameLayout root = new FrameLayout(this);
        root.setBackgroundColor(Color.WHITE);

        webView = new WebView(this);
        root.addView(webView, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));

        progressBar = new ProgressBar(this, null, android.R.attr.progressBarStyleHorizontal);
        progressBar.setMax(100);
        root.addView(progressBar, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, dp(4), Gravity.TOP));

        offlineView = buildOfflineView();
        root.addView(offlineView, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));

        setContentView(root);
        configureWebView();

        if (savedInstanceState != null && webView.restoreState(savedInstanceState) != null) {
            return;
        }
        Uri data = getIntent().getData();
        webView.loadUrl(data != null && isAppUrl(data) ? data.toString() : appUrl);
    }

    private void configureWebView() {
        WebSettings s = webView.getSettings();
        s.setJavaScriptEnabled(true);
        s.setDomStorageEnabled(true);
        s.setDatabaseEnabled(true);
        s.setLoadWithOverviewMode(true);
        s.setUseWideViewPort(true);
        s.setSupportZoom(false);
        s.setAllowFileAccess(false);
        s.setAllowContentAccess(true);
        s.setMediaPlaybackRequiresUserGesture(false);
        s.setMixedContentMode(WebSettings.MIXED_CONTENT_NEVER_ALLOW);
        s.setUserAgentString(s.getUserAgentString() + UA_TOKEN);

        CookieManager cookies = CookieManager.getInstance();
        cookies.setAcceptCookie(true);
        cookies.setAcceptThirdPartyCookies(webView, true);

        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                Uri uri = Uri.parse(url);
                if (isAppUrl(uri)) {
                    return false;
                }
                openExternally(uri);
                return true;
            }

            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                mainFrameError = false;
                progressBar.setVisibility(View.VISIBLE);
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                progressBar.setVisibility(View.GONE);
                if (!mainFrameError) {
                    offlineView.setVisibility(View.GONE);
                }
                CookieManager.getInstance().flush();
            }

            @Override
            public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
                if (request.isForMainFrame()) {
                    showOffline();
                }
            }

            @SuppressWarnings("deprecation")
            @Override
            public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {
                // Appelée seulement avant Android 6 ; conservée par sécurité.
                showOffline();
            }
        });

        webView.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                progressBar.setProgress(newProgress);
            }

            @Override
            public boolean onShowFileChooser(WebView view, ValueCallback<Uri[]> callback,
                                             FileChooserParams params) {
                // Choix d'une photo de profil depuis la galerie ou les fichiers.
                if (fileCallback != null) {
                    fileCallback.onReceiveValue(null);
                }
                fileCallback = callback;
                try {
                    startActivityForResult(params.createIntent(), FILE_CHOOSER_REQUEST);
                } catch (ActivityNotFoundException e) {
                    fileCallback = null;
                    toast(getString(R.string.no_app));
                    return false;
                }
                return true;
            }
        });

        webView.setDownloadListener(new DownloadListener() {
            @Override
            public void onDownloadStart(String url, String userAgent, String contentDisposition,
                                        String mimetype, long contentLength) {
                openExternally(Uri.parse(url));
            }
        });
    }

    private boolean isAppUrl(Uri uri) {
        String scheme = uri.getScheme();
        return ("https".equals(scheme) || "http".equals(scheme))
                && appHost != null && appHost.equalsIgnoreCase(uri.getHost());
    }

    /** WhatsApp, téléphone, e-mail, LinkedIn… s'ouvrent dans l'application adaptée. */
    private void openExternally(Uri uri) {
        Intent intent;
        if ("intent".equals(uri.getScheme())) {
            try {
                intent = Intent.parseUri(uri.toString(), Intent.URI_INTENT_SCHEME);
                intent.addCategory(Intent.CATEGORY_BROWSABLE);
                intent.setComponent(null);
                intent.setSelector(null);
            } catch (Exception e) {
                return;
            }
        } else {
            intent = new Intent(Intent.ACTION_VIEW, uri);
        }
        try {
            startActivity(intent);
        } catch (ActivityNotFoundException e) {
            toast(getString(R.string.no_app));
        }
    }

    private void showOffline() {
        mainFrameError = true;
        progressBar.setVisibility(View.GONE);
        offlineView.setVisibility(View.VISIBLE);
    }

    private LinearLayout buildOfflineView() {
        LinearLayout box = new LinearLayout(this);
        box.setOrientation(LinearLayout.VERTICAL);
        box.setGravity(Gravity.CENTER);
        box.setPadding(dp(32), dp(32), dp(32), dp(32));
        box.setBackgroundColor(Color.WHITE);
        box.setVisibility(View.GONE);
        box.setClickable(true);

        TextView title = new TextView(this);
        title.setText(R.string.offline_title);
        title.setTextSize(22);
        title.setTypeface(Typeface.DEFAULT_BOLD);
        title.setTextColor(Color.rgb(23, 25, 35));
        title.setGravity(Gravity.CENTER);
        box.addView(title);

        TextView text = new TextView(this);
        text.setText(R.string.offline_text);
        text.setTextSize(16);
        text.setTextColor(Color.rgb(74, 78, 92));
        text.setGravity(Gravity.CENTER);
        text.setPadding(0, dp(12), 0, dp(24));
        box.addView(text);

        Button retry = new Button(this);
        retry.setText(R.string.retry);
        retry.setTextColor(Color.WHITE);
        retry.setBackgroundColor(Color.rgb(17, 17, 238));
        retry.setPadding(dp(28), 0, dp(28), 0);
        retry.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String url = webView.getUrl();
                if (url == null || "about:blank".equals(url)) {
                    webView.loadUrl(getString(R.string.app_url));
                } else {
                    webView.reload();
                }
            }
        });
        box.addView(retry, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT, dp(48)));
        return box;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == FILE_CHOOSER_REQUEST && fileCallback != null) {
            fileCallback.onReceiveValue(WebChromeClient.FileChooserParams.parseResult(resultCode, data));
            fileCallback = null;
            return;
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Uri data = intent.getData();
        if (data != null && isAppUrl(data)) {
            webView.loadUrl(data.toString());
        }
    }

    @Override
    public void onBackPressed() {
        if (offlineView.getVisibility() == View.VISIBLE || !webView.canGoBack()) {
            super.onBackPressed();
        } else {
            webView.goBack();
        }
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        webView.saveState(outState);
    }

    @Override
    protected void onPause() {
        super.onPause();
        CookieManager.getInstance().flush();
        webView.onPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        webView.onResume();
    }

    @Override
    protected void onDestroy() {
        if (webView != null) {
            webView.destroy();
        }
        super.onDestroy();
    }

    private int dp(int value) {
        return Math.round(value * getResources().getDisplayMetrics().density);
    }

    private void toast(String message) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show();
    }
}
