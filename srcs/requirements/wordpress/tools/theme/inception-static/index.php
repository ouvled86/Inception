<?php get_header(); ?>

<section class="hero reveal" id="home">
  <p class="eyebrow">WordPress Blog</p>
  <h1><?php bloginfo('name'); ?></h1>
  <p class="subtitle"><?php bloginfo('description'); ?></p>
  <div class="hero-actions">
    <a class="btn btn-solid" href="#posts">Read Posts</a>
    <a class="btn btn-outline" href="<?php echo esc_url(home_url('/static/')); ?>">View Static Site</a>
  </div>
  <ul class="hero-metrics">
    <li><span>NGINX</span> TLS only</li>
    <li><span>WordPress</span> PHP-FPM</li>
    <li><span>MariaDB</span> Storage</li>
  </ul>
</section>

<section id="posts" class="section reveal">
  <div class="section-head">
    <div>
      <p class="eyebrow">Blog</p>
      <h2>Latest Posts</h2>
    </div>
  </div>
  <div class="project-slider">
    <?php if (have_posts()) : ?>
      <?php while (have_posts()) : the_post(); ?>
        <article class="project-card reveal">
          <span class="project-domain"><?php echo esc_html(get_the_date()); ?></span>
          <h3><?php the_title(); ?></h3>
          <p><?php echo esc_html(wp_strip_all_tags(get_the_excerpt())); ?></p>
          <a href="<?php the_permalink(); ?>">Read more</a>
        </article>
      <?php endwhile; ?>
    <?php else : ?>
      <article class="project-card reveal">
        <span class="project-domain">No posts</span>
        <h3>Nothing published yet</h3>
        <p>Create a post in WordPress admin and it will appear here.</p>
        <a href="<?php echo esc_url(home_url('/wp-admin/')); ?>">Open admin</a>
      </article>
    <?php endif; ?>
  </div>
</section>

<section id="about" class="section reveal">
  <div class="section-head">
    <div>
      <p class="eyebrow">About</p>
      <h2>Static-inspired theme</h2>
    </div>
  </div>
  <div class="resume-card reveal">
    <h2>Shared visual language</h2>
    <p>
      This WordPress theme reuses the static site styling to keep the portfolio
      and blog visually consistent.
    </p>
  </div>
</section>

<?php get_footer(); ?>
