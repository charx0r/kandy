<?php

/**
 * Implementation of hook_imagecache_default_presets().
 */
function gallery_imagecache_default_presets() {
  $items = array(
    'lightbox_galleries' => array(
      'presetname' => 'lightbox_galleries',
      'actions' => array(
        '0' => array(
          'weight' => '0',
          'module' => 'imagecache',
          'action' => 'imagecache_scale',
          'data' => array(
            'width' => '800',
            'height' => '600',
            'upscale' => 1,
          ),
        ),
      ),
    ),
    'thumbnail_galleries' => array(
      'presetname' => 'thumbnail_galleries',
      'actions' => array(
        '0' => array(
          'weight' => '0',
          'module' => 'imagecache',
          'action' => 'imagecache_scale_and_crop',
          'data' => array(
            'width' => '180',
            'height' => '120',
          ),
        ),
      ),
    ),
  );
  return $items;
}

/**
 * Implementation of hook_node_info().
 */
function gallery_node_info() {
  $items = array(
    'image' => array(
      'name' => t('Image'),
      'module' => 'features',
      'description' => t('An Image will let you create an image for the image gallery.'),
      'has_title' => '1',
      'title_label' => t('Image title'),
      'has_body' => '0',
      'body_label' => '',
      'min_word_count' => '0',
      'help' => '',
    ),
  );
  return $items;
}

/**
 * Implementation of hook_views_api().
 */
function gallery_views_api() {
  return array(
    'api' => '2',
  );
}
