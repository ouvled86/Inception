const revealNodes = document.querySelectorAll(".reveal");

const observer = new IntersectionObserver(
    (entries) => {
        entries.forEach((entry) => {
            if (!entry.isIntersecting) {
                return;
            }
            entry.target.classList.add("is-visible");
            observer.unobserve(entry.target);
        });
    },
    {
        threshold: 0.2,
    }
);

revealNodes.forEach((node, index) => {
    node.style.transitionDelay = `${Math.min(index * 80, 300)}ms`;
    observer.observe(node);
});

// Project slider buttons
const slider = document.querySelector(".project-slider");
const btnLeft = document.querySelector(".slider-btn-left");
const btnRight = document.querySelector(".slider-btn-right");

const updateSliderButtons = () => {
    if (!slider || !btnLeft || !btnRight) {
        return;
    }
    const maxScroll = slider.scrollWidth - slider.clientWidth;
    btnLeft.disabled = slider.scrollLeft <= 4;
    btnRight.disabled = slider.scrollLeft >= maxScroll - 4;
};

const scrollSliderByCard = (direction) => {
    if (!slider) {
        return;
    }
    const card = slider.querySelector(".project-card");
    const cardWidth = card ? card.getBoundingClientRect().width : slider.clientWidth * 0.8;
    const gap = 32;
    slider.scrollBy({
        left: direction * (cardWidth + gap),
        behavior: "smooth",
    });
};

if (slider && btnLeft && btnRight) {
    btnLeft.addEventListener("click", () => scrollSliderByCard(-1));
    btnRight.addEventListener("click", () => scrollSliderByCard(1));
    slider.addEventListener("scroll", updateSliderButtons, { passive: true });
    window.addEventListener("resize", updateSliderButtons);
    updateSliderButtons();
}

const orbA = document.querySelector(".orb-a");
const orbB = document.querySelector(".orb-b");

window.addEventListener(
    "mousemove",
    (event) => {
        const xRatio = event.clientX / window.innerWidth;
        const yRatio = event.clientY / window.innerHeight;

        if (orbA) {
            orbA.style.transform = `translate(${xRatio * 26}px, ${yRatio * 20}px)`;
        }
        if (orbB) {
            orbB.style.transform = `translate(${-xRatio * 20}px, ${-yRatio * 24}px)`;
        }
    },
    { passive: true }
);

const brandTrigger = document.getElementById("brandTrigger");

if (brandTrigger) {
    let brandClicks = 0;

    brandTrigger.addEventListener("click", (event) => {
        brandClicks += 1;

        if (brandClicks < 7) {
            return;
        }

        brandClicks = 0;

        const easterUrl = (brandTrigger.dataset.easterUrl || "").trim();

        if (!easterUrl || easterUrl.includes("replace-with-your-bunny-image-url")) {
            event.preventDefault();
            return;
        }

        event.preventDefault();
        window.location.href = easterUrl;
    });
}
