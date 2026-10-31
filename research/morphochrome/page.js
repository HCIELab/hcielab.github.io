const research = document.querySelector('#research');
document.querySelector('[data-open-research]').addEventListener('click', () => {
  research.open = true;
});

const citationButton = document.querySelector('#copy-citation');
const citationStatus = document.querySelector('#citation-status');
citationButton.addEventListener('click', async () => {
  const citation = document.querySelector('#bibtex').textContent;
  try {
    await navigator.clipboard.writeText(citation);
    citationButton.textContent = 'Citation copied ✓';
    citationStatus.textContent = 'BibTeX citation copied to clipboard.';
    window.setTimeout(() => {
      citationButton.innerHTML = 'Copy citation <span aria-hidden="true">↗</span>';
    }, 2400);
  } catch {
    document.querySelector('#citation-fallback').open = true;
    citationStatus.textContent = 'Select and copy the BibTeX citation below.';
  }
});

if (location.hash === '#research') research.open = true;

// Native horizontal scrolling supports touch and trackpad swipes; buttons and
// arrow keys provide the same two-photo comparison without a swipe gesture.
document.querySelectorAll('.color-carousel').forEach((carousel) => {
  const viewport = carousel.querySelector('.carousel-viewport');
  const slides = [...carousel.querySelectorAll('.carousel-slide')];
  const previous = carousel.querySelector('.carousel-previous');
  const next = carousel.querySelector('.carousel-next');
  const count = carousel.querySelector('.carousel-count');
  const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
  let active = 0;
  let scrollTimer;
  let drag;

  function update() {
    active = Math.max(0, Math.min(slides.length - 1, Math.round(viewport.scrollLeft / viewport.clientWidth)));
    previous.disabled = active === 0;
    next.disabled = active === slides.length - 1;
    count.textContent = `${active + 1} / ${slides.length}`;
  }

  function show(index) {
    const target = Math.max(0, Math.min(slides.length - 1, index));
    viewport.scrollTo({left: viewport.clientWidth * target, behavior: reducedMotion.matches ? 'instant' : 'smooth'});
  }

  previous.addEventListener('click', () => show(active - 1));
  next.addEventListener('click', () => show(active + 1));
  viewport.addEventListener('keydown', (event) => {
    const target = {ArrowLeft: active - 1, ArrowRight: active + 1, Home: 0, End: slides.length - 1}[event.key];
    if (target !== undefined) {
      event.preventDefault();
      show(target);
    }
  });
  viewport.addEventListener('scroll', () => {
    window.clearTimeout(scrollTimer);
    scrollTimer = window.setTimeout(update, 100);
  }, {passive: true});
  viewport.addEventListener('scrollend', update);
  // Mouse dragging complements native touch scrolling without intercepting it.
  viewport.addEventListener('pointerdown', (event) => {
    if (event.pointerType !== 'mouse' || event.button !== 0) return;
    drag = {id: event.pointerId, startX: event.clientX, scroll: viewport.scrollLeft};
    viewport.setPointerCapture(event.pointerId);
    viewport.classList.add('is-dragging');
  });
  viewport.addEventListener('pointermove', (event) => {
    if (drag && event.pointerId === drag.id) viewport.scrollLeft = drag.scroll + drag.startX - event.clientX;
  });
  function endDrag(event) {
    if (!drag || event.pointerId !== drag.id) return;
    drag = undefined;
    viewport.classList.remove('is-dragging');
    if (viewport.hasPointerCapture(event.pointerId)) viewport.releasePointerCapture(event.pointerId);
    show(Math.round(viewport.scrollLeft / viewport.clientWidth));
  }
  viewport.addEventListener('pointerup', endDrag);
  viewport.addEventListener('pointercancel', endDrag);
  new ResizeObserver(() => {
    if (viewport.clientWidth) viewport.scrollTo({left: active * viewport.clientWidth, behavior: 'instant'});
  }).observe(viewport);
  carousel.querySelector('.carousel-controls').hidden = false;
  update();
});
