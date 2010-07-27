<?php

/**
 * Implementation of hook_imagecache_default_presets().
 */
function press_room_imagecache_default_presets() {
  $items = array(
    'Thumbnail' => array(
      'presetname' => 'Thumbnail',
      'actions' => array(
        '0' => array(
          'weight' => '0',
          'module' => 'imagecache',
          'action' => 'imagecache_scale_and_crop',
          'data' => array(
            'width' => '150',
            'height' => '113',
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
function press_room_node_info() {
  $items = array(
    'news_item' => array(
      'name' => t('News Item'),
      'module' => 'features',
      'description' => t('This will create a news item on the website.'),
      'has_title' => '1',
      'title_label' => t('News title'),
      'has_body' => '1',
      'body_label' => t('Body'),
      'min_word_count' => '0',
      'help' => '',
    ),
  );
  return $items;
}

/**
 * Implementation of hook_views_api().
 */
function press_room_views_api() {
  return array(
    'api' => '2',
  );
}
