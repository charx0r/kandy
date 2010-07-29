<?php

/**
 * Implementation of hook_node_info().
 */
function videos_node_info() {
  $items = array(
    'video' => array(
      'name' => t('Video'),
      'module' => 'features',
      'description' => t('This content will let you upload a video into the video Gallery.'),
      'has_title' => '1',
      'title_label' => t('Title'),
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
function videos_views_api() {
  return array(
    'api' => '2',
  );
}
