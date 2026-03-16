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

// Project Slider Parallax Effect
const slider = document.querySelector('.project-slider');
if (slider) {
    slider.addEventListener('scroll', () => {
        const cards = slider.querySelectorAll('.project-card');
        const scrollX = slider.scrollLeft;
        const sliderWidth = slider.clientWidth;

        cards.forEach(card => {
            const cardX = card.offsetLeft;
            const distance = Math.abs(cardX - scrollX - (sliderWidth / 10));
            const scale = Math.max(0.92, 1 - distance / 2000);
            const rotate = (cardX - scrollX - (sliderWidth / 10)) / 40;
            
            card.style.transform = `scale(${scale}) rotateY(${rotate}deg)`;
        });
    });
    // Trigger initial state
    slider.dispatchEvent(new Event('scroll'));
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
