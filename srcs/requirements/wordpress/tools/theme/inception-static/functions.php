<?php

function inception_static_enqueue_assets() {
    wp_enqueue_style(
        'inception-static-style',
        get_stylesheet_uri(),
        array(),
        '1.0.0'
    );

    wp_enqueue_style(
        'boxicons',
        'https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css',
        array(),
        '2.1.4'
    );

    wp_enqueue_script(
        'inception-static-app',
        get_template_directory_uri() . '/app.js',
        array(),
        '1.0.0',
        true
    );
}
add_action('wp_enqueue_scripts', 'inception_static_enqueue_assets');

function inception_static_setup() {
    add_theme_support('title-tag');
    add_theme_support('post-thumbnails');
}
add_action('after_setup_theme', 'inception_static_setup');
