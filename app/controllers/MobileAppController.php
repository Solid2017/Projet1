<?php
declare(strict_types=1);

class MobileAppController
{
    public function index(): void
    {
        if (!MobileApp::available()) {
            http_response_code(404);
            View::render('errors/404');
            return;
        }

        View::render('app/index', [
            'apkUrl' => MobileApp::apkUrl(),
            'apkSize' => MobileApp::apkSizeLabel(),
            'inApp' => MobileApp::isInApp(),
            'ios' => MobileApp::isIos(),
            'hideAppBanner' => true,
        ]);
    }
}
