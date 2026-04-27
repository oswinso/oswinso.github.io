import PhotoSwipeLightbox from "https://cdn.jsdelivr.net/npm/photoswipe@5.4.4/dist/photoswipe-lightbox.esm.min.js";
import PhotoSwipe from "https://cdn.jsdelivr.net/npm/photoswipe@5.4.4/dist/photoswipe.esm.min.js";
const photoswipe = new PhotoSwipeLightbox({
  gallery: ".pswp-gallery",
  children: "a[data-pswp-width][data-pswp-height]",
  bgOpacity: 0.72,
  initialZoomLevel: "fit",
  secondaryZoomLevel: 1,
  maxZoomLevel: 2,
  clickToCloseNonZoomable: true,
  bgClickAction: "close",
  tapAction: "close",
  paddingFn: (viewportSize) => ({
    top: Math.max(48, viewportSize.y * 0.08),
    bottom: Math.max(48, viewportSize.y * 0.08),
    left: Math.max(24, viewportSize.x * 0.08),
    right: Math.max(24, viewportSize.x * 0.08),
  }),
  pswpModule: PhotoSwipe,
});
photoswipe.init();
