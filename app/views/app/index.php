<div class="container">
  <div class="card app-page">
    <img class="app-page-icon" src="<?= Router::url('assets/app/icon-192.png') ?>" alt="" width="88" height="88">
    <h1>L'application IgoTech IA</h1>
    <p class="app-page-lead">Tes parcours et ton mentor IA en un geste, depuis l'écran d'accueil de ton téléphone Android. Tu te connectes avec <strong>le même compte</strong> que sur le site : ta progression, tes conversations et ton abonnement sont les mêmes partout.</p>

    <?php if ($inApp): ?>
      <div class="alert alert-success">Tu utilises déjà l'application. 🎉</div>
    <?php elseif ($ios): ?>
      <div class="alert alert-error">L'application est disponible pour Android uniquement. Sur iPhone, continue simplement à utiliser IgoTech IA dans Safari : ajoute la page à l'écran d'accueil avec le bouton Partager, puis « Sur l'écran d'accueil ».</div>
    <?php else: ?>
      <a class="btn btn-primary app-page-download" href="<?= View::e($apkUrl) ?>" download="igotech-ia.apk">Télécharger l'application Android</a>
      <p class="hint">Fichier APK · <?= View::e($apkSize) ?> · Android 6 ou plus récent</p>

      <h2>Comment l'installer ?</h2>
      <ol class="pay-steps">
        <li><strong>Télécharge le fichier</strong> avec le bouton ci-dessus. Si Chrome affiche « Ce type de fichier peut être dangereux », touche <strong>Télécharger quand même</strong>.</li>
        <li><strong>Ouvre le fichier</strong> igotech-ia.apk depuis la notification ou le dossier Téléchargements.</li>
        <li>Si Android demande l'autorisation, touche <strong>Paramètres</strong>, active <strong>Autoriser cette source</strong>, puis reviens en arrière.</li>
        <li>Touche <strong>Installer</strong>. Si Play Protect affiche un avertissement, touche <strong>Plus de détails</strong> puis <strong>Installer quand même</strong> : l'application n'est simplement pas (encore) publiée sur le Play Store.</li>
        <li>Ouvre <strong>IgoTech IA</strong> depuis ton écran d'accueil et connecte-toi avec ton e-mail et ton mot de passe habituels.</li>
      </ol>
      <p class="hint">Pour mettre à jour l'application plus tard, il suffit de télécharger à nouveau le fichier depuis cette page et de l'installer par-dessus : tes données sont conservées.</p>
    <?php endif; ?>
  </div>
</div>
