let slides = document.querySelectorAll('.slide');
let indicators = document.querySelectorAll('.indicator');
let currentIndex = 0;
let slideInterval;

function showSlide(index) {
    if (index < 0) index = slides.length - 1;
    if (index >= slides.length) index = 0;

    slides.forEach(slide => slide.classList.remove('active'));
    indicators.forEach(ind => ind.classList.remove('active'));

    slides[index].classList.add('active');
    indicators[index].classList.add('active');

    currentIndex = index;
}

function nextSlide() {
    showSlide(currentIndex + 1);
}

window.currentSlide = function(index) {
    showSlide(index);
    resetInterval();
}

function resetInterval() {
    clearInterval(slideInterval);
    slideInterval = setInterval(nextSlide, 5000);
}

slideInterval = setInterval(nextSlide, 5000);

const slideshowContainer = document.querySelector('.slideshow-container');
if (slideshowContainer) {
    slideshowContainer.addEventListener('mouseenter', () => {
        clearInterval(slideInterval);
    });

    slideshowContainer.addEventListener('mouseleave', () => {
        slideInterval = setInterval(nextSlide, 5000);
    });
}

