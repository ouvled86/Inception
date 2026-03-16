<!doctype html>
<html <?php language_attributes(); ?>>
  <head>
    <meta charset="<?php bloginfo('charset'); ?>" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <?php wp_head(); ?>
  </head>
  <body <?php body_class(); ?>>
    <main>
      <nav class="reveal">
        <a href="<?php echo esc_url(home_url('/')); ?>">Blog</a>
        <a href="<?php echo esc_url(home_url('/static/')); ?>">Static Site</a>
        <a href="#posts">Posts</a>
        <a href="#about">About</a>
      </nav>
