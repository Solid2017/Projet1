<?php
declare(strict_types=1);

class CertificateController
{
    /** Page publique, accessible sans connexion : preuve vérifiable + partage social. */
    public function show(string $code): void
    {
        $certificate = Certificate::findByCode($code);
        if (!$certificate) {
            http_response_code(404);
            View::render('errors/404');
            return;
        }

        View::render('certificate/show', [
            'certificate' => $certificate,
            'shareUrl' => rtrim((string) APP_CONFIG['app']['url'], '/') . Router::url('certificate/' . $certificate['code']),
            'noFooter' => false,
        ]);
    }
}
