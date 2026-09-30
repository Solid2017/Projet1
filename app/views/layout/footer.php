<?php
$social = APP_CONFIG['social'] ?? [];
$waNumber = $social['whatsapp_number'] ?? '';
$fbUrl = $social['facebook_url'] ?? '';
?>
<?php if (!empty($waNumber)): ?>
<a class="whatsapp-float" target="_blank" rel="noopener"
   href="https://wa.me/<?= View::e($waNumber) ?>?text=<?= urlencode('Bonjour, j\'ai une question sur IgoTech IA.') ?>"
   aria-label="Contacter IgoTech IA sur WhatsApp">💬</a>
<?php endif; ?>
<?php if (!isset($noFooter)): ?>
<footer class="site-footer">
  <p>IgoTech IA — plateforme de mentorat par IA pour les carrières informatiques.</p>
  <?php if (!empty($waNumber) || !empty($fbUrl)): ?>
  <p style="margin-top:8px;">
    <?php if (!empty($waNumber)): ?><a href="https://wa.me/<?= View::e($waNumber) ?>" target="_blank" rel="noopener">WhatsApp</a><?php endif; ?>
    <?php if (!empty($waNumber) && !empty($fbUrl)): ?> · <?php endif; ?>
    <?php if (!empty($fbUrl)): ?><a href="<?= View::e($fbUrl) ?>" target="_blank" rel="noopener">Facebook</a><?php endif; ?>
  </p>
  <?php endif; ?>
</footer>
<?php endif; ?>
<script src="<?= Router::url('assets/js/app.js') ?>"></script>
<?php if (!empty($extraScripts)) foreach ($extraScripts as $src): ?>
<script src="<?= Router::url($src) ?>"></script>
<?php endforeach; ?>
</body>
</html>
