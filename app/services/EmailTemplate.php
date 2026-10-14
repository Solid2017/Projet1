<?php
declare(strict_types=1);

/**
 * Gabarit HTML des e-mails IgoTech IA : tableaux + styles en ligne, seule
 * mise en page fiable dans Gmail, Outlook et les clients mobiles.
 */
class EmailTemplate
{
    /**
     * @param array{
     *   preheader?: string,
     *   title: string,
     *   paragraphs: string[],
     *   stats?: array<int, array{0:string,1:string}>,
     *   cta_label?: string,
     *   cta_url?: string,
     *   after?: string[],
     *   unsubscribe_url?: string
     * } $o Les paragraphes et 'after' sont du HTML déjà échappé.
     */
    public static function render(array $o): string
    {
        $e = static fn (string $v): string => htmlspecialchars($v, ENT_QUOTES, 'UTF-8');
        $font = "'Segoe UI',Roboto,Helvetica,Arial,sans-serif";

        $paragraphs = '';
        foreach ($o['paragraphs'] as $p) {
            $paragraphs .= '<p style="margin:0 0 16px;font-size:16px;line-height:1.6;color:#4A4E5C;">' . $p . '</p>';
        }

        $stats = '';
        if (!empty($o['stats'])) {
            $cells = '';
            foreach ($o['stats'] as [$value, $label]) {
                $cells .= '<td align="center" style="padding:16px 8px;background:#F5F6FB;border-radius:14px;">'
                    . '<div style="font-size:30px;font-weight:800;color:#1111EE;line-height:1;">' . $e($value) . '</div>'
                    . '<div style="font-size:13px;color:#767B8A;margin-top:6px;">' . $e($label) . '</div></td>'
                    . '<td width="12"></td>';
            }
            $stats = '<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin:4px 0 20px;"><tr>' . $cells . '</tr></table>';
        }

        $cta = '';
        if (!empty($o['cta_label']) && !empty($o['cta_url'])) {
            $cta = '<table role="presentation" cellpadding="0" cellspacing="0" style="margin:8px 0 22px;"><tr>'
                . '<td style="background:#1111EE;border-radius:999px;">'
                . '<a href="' . $e($o['cta_url']) . '" style="display:inline-block;padding:15px 30px;font-family:' . $font . ';font-size:16px;font-weight:700;color:#FFFFFF;text-decoration:none;">'
                . $e($o['cta_label']) . ' &rarr;</a></td></tr></table>';
        }

        $after = '';
        foreach ($o['after'] ?? [] as $p) {
            $after .= '<p style="margin:0 0 12px;font-size:14px;line-height:1.6;color:#767B8A;">' . $p . '</p>';
        }

        $unsubscribe = '';
        if (!empty($o['unsubscribe_url'])) {
            $unsubscribe = '<br><a href="' . $e($o['unsubscribe_url']) . '" style="color:#9A9FB0;">Ne plus recevoir ces e-mails</a>';
        }

        $preheader = $e($o['preheader'] ?? '');
        $title = $e($o['title']);

        return <<<HTML
<!doctype html>
<html lang="fr"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>{$title}</title></head>
<body style="margin:0;padding:0;background:#F5F6FB;font-family:{$font};">
<div style="display:none;max-height:0;overflow:hidden;opacity:0;">{$preheader}</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#F5F6FB;">
  <tr><td align="center" style="padding:28px 14px;">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:560px;">
      <tr><td style="padding:0 6px 18px;font-size:22px;font-weight:800;letter-spacing:-.5px;">
        <span style="color:#1111EE;">Igo</span><span style="color:#EE1111;">Tech</span> <span style="color:#171923;">IA</span>
      </td></tr>
      <tr><td style="background:#FFFFFF;border-radius:24px;padding:34px 32px 26px;border:1px solid #E4E6EF;">
        <div style="height:6px;width:56px;border-radius:6px;background:#EE1111;margin-bottom:22px;"></div>
        <h1 style="margin:0 0 18px;font-size:24px;line-height:1.3;color:#171923;font-weight:800;">{$title}</h1>
        {$paragraphs}{$stats}{$cta}{$after}
      </td></tr>
      <tr><td align="center" style="padding:20px 10px;font-size:12px;line-height:1.6;color:#9A9FB0;">
        IgoTech IA — le mentor IA des carrières tech, au Tchad et en Afrique centrale.{$unsubscribe}
      </td></tr>
    </table>
  </td></tr>
</table>
</body></html>
HTML;
    }
}
