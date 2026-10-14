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
  <p class="social-icons">
    <?php if (!empty($waNumber)): ?>
    <a href="https://wa.me/<?= View::e($waNumber) ?>" target="_blank" rel="noopener" class="social-icon social-icon-whatsapp" aria-label="IgoTech IA sur WhatsApp">
      <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor" aria-hidden="true"><path d="M12.02 2c-5.5 0-9.98 4.48-9.98 9.98 0 1.76.46 3.48 1.34 5L2 22l5.17-1.35a9.96 9.96 0 0 0 4.85 1.24h.01c5.5 0 9.98-4.48 9.98-9.98S17.52 2 12.02 2Zm0 18.26h-.01a8.3 8.3 0 0 1-4.23-1.16l-.3-.18-3.07.8.82-2.99-.2-.31a8.26 8.26 0 0 1-1.27-4.44c0-4.58 3.73-8.3 8.31-8.3 2.22 0 4.3.86 5.87 2.43a8.24 8.24 0 0 1 2.43 5.87c0 4.58-3.73 8.3-8.31 8.3Zm4.55-6.22c-.25-.12-1.47-.72-1.7-.81-.23-.08-.39-.12-.56.13-.17.25-.64.81-.78.97-.14.17-.29.19-.54.06-.25-.12-1.04-.38-1.98-1.21-.73-.65-1.23-1.46-1.37-1.7-.14-.25-.02-.38.11-.5.11-.11.25-.29.37-.43.12-.14.17-.25.25-.41.08-.17.04-.31-.02-.43-.06-.12-.56-1.34-.76-1.84-.2-.48-.41-.42-.56-.42h-.48c-.17 0-.43.06-.66.31-.23.25-.86.84-.86 2.05 0 1.21.88 2.38 1 2.54.12.17 1.74 2.65 4.21 3.71.59.25 1.05.41 1.41.52.59.19 1.13.16 1.56.1.48-.07 1.47-.6 1.67-1.18.21-.58.21-1.08.15-1.18-.06-.1-.23-.16-.48-.29Z"/></svg>
    </a>
    <?php endif; ?>
    <?php if (!empty($fbUrl)): ?>
    <a href="<?= View::e($fbUrl) ?>" target="_blank" rel="noopener" class="social-icon social-icon-facebook" aria-label="IgoTech IA sur Facebook">
      <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor" aria-hidden="true"><path d="M22 12.06C22 6.5 17.52 2 12 2S2 6.5 2 12.06c0 5.02 3.66 9.18 8.44 9.94v-7.03H7.9v-2.91h2.54V9.84c0-2.51 1.49-3.9 3.77-3.9 1.09 0 2.23.2 2.23.2v2.46h-1.26c-1.24 0-1.63.78-1.63 1.57v1.89h2.78l-.44 2.91h-2.34V22c4.78-.76 8.44-4.92 8.44-9.94Z"/></svg>
    </a>
    <?php endif; ?>
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
