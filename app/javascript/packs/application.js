import { initNavScroll } from '../components/init_nav_scroll'

import "bootstrap";

import "controllers"

import { initVideoScroll } from '../components/init_video_scroll'

if (document.querySelector('.results-video')) initVideoScroll();

if (document.querySelector('body.home-page')) initNavScroll();
