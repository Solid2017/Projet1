<?php if (!isset($noFooter)): ?>
<footer class="site-footer">
  IgoTech IA — plateforme de mentorat par IA pour les carrières informatiques.
</footer>
<?php endif; ?>
<script src="<?= Router::url('assets/js/app.js') ?>"></script>
<?php if (!empty($extraScripts)) foreach ($extraScripts as $src): ?>
<script src="<?= Router::url($src) ?>"></script>
<?php endforeach; ?>
</body>
</html>
