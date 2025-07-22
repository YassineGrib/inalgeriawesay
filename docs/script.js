// Custom JavaScript for In Algeria We Say Website

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all features
    initTypingAnimation();
    initScrollAnimations();
    initCounterAnimation();
    initQRCode();
    initSmoothScrolling();
    initNavbarScroll();
});

// Typing Animation for Hero Text
function initTypingAnimation() {
    const typingText = document.querySelector('.typing-text');
    if (!typingText) return;
    
    const texts = [
        'Learn Algerian Arabic',
        'Explore Rich Culture',
        'Master 4 Dialects',
        'Connect with Heritage'
    ];
    
    let textIndex = 0;
    let charIndex = 0;
    let isDeleting = false;
    
    function typeText() {
        const currentText = texts[textIndex];
        
        if (isDeleting) {
            typingText.textContent = currentText.substring(0, charIndex - 1);
            charIndex--;
        } else {
            typingText.textContent = currentText.substring(0, charIndex + 1);
            charIndex++;
        }
        
        let typeSpeed = isDeleting ? 50 : 100;
        
        if (!isDeleting && charIndex === currentText.length) {
            typeSpeed = 2000; // Pause at end
            isDeleting = true;
        } else if (isDeleting && charIndex === 0) {
            isDeleting = false;
            textIndex = (textIndex + 1) % texts.length;
            typeSpeed = 500; // Pause before next text
        }
        
        setTimeout(typeText, typeSpeed);
    }
    
    typeText();
}

// Scroll Animations
function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, observerOptions);
    
    // Add fade-in class to elements
    const animatedElements = document.querySelectorAll('.feature-card, .stat-card, .tech-card, .innovation-card, .about-card, .usage-step, .demo-highlight, .section-title, .section-subtitle');
    animatedElements.forEach(el => {
        el.classList.add('fade-in');
        observer.observe(el);
    });
}

// Counter Animation for Statistics
function initCounterAnimation() {
    const counters = document.querySelectorAll('.stat-number');
    const speed = 200; // Animation speed
    
    const observerOptions = {
        threshold: 0.5
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counter = entry.target;
                const target = parseInt(counter.getAttribute('data-target'));
                const increment = target / speed;
                let current = 0;
                
                const updateCounter = () => {
                    if (current < target) {
                        current += increment;
                        counter.textContent = Math.ceil(current);
                        setTimeout(updateCounter, 10);
                    } else {
                        counter.textContent = target;
                    }
                };
                
                updateCounter();
                observer.unobserve(counter); // Run animation only once
            }
        });
    }, observerOptions);
    
    counters.forEach(counter => {
        observer.observe(counter);
    });
}

// QR Code Generation
function initQRCode() {
    const qrContainer = document.getElementById('qrcode');
    if (!qrContainer) return;

    // Generate QR code for local APK download
    let appUrl = window.location.href;
    if (appUrl.includes('index.html')) {
        appUrl = appUrl.replace('index.html', 'araloug.apk');
    } else {
        appUrl = appUrl + (appUrl.endsWith('/') ? '' : '/') + 'araloug.apk';
    }

    console.log('QR Code URL:', appUrl);

    QRCode.toCanvas(qrContainer, appUrl, {
        width: 200,
        height: 200,
        colorDark: '#1B5E20',
        colorLight: '#FFFFFF',
        margin: 2,
        errorCorrectionLevel: 'M'
    }, function(error) {
        if (error) {
            console.error('QR Code generation failed:', error);
            qrContainer.innerHTML = '<div class="qr-placeholder"><i class="fas fa-qrcode fa-5x text-muted"></i><p class="mt-2">QR Code Error</p></div>';
        } else {
            console.log('QR Code generated successfully');
        }
    });
}

// Smooth Scrolling for Navigation Links
function initSmoothScrolling() {
    const navLinks = document.querySelectorAll('a[href^="#"]');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                const offsetTop = targetSection.offsetTop - 80; // Account for fixed navbar
                
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
                
                // Close mobile menu if open
                const navbarCollapse = document.querySelector('.navbar-collapse');
                if (navbarCollapse.classList.contains('show')) {
                    const bsCollapse = new bootstrap.Collapse(navbarCollapse);
                    bsCollapse.hide();
                }
            }
        });
    });
}

// Navbar Scroll Effect
function initNavbarScroll() {
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 100) {
            navbar.style.background = 'rgba(27, 94, 32, 0.95)';
            navbar.style.backdropFilter = 'blur(10px)';
        } else {
            navbar.style.background = 'linear-gradient(135deg, #1B5E20 0%, #2E7D32 100%)';
            navbar.style.backdropFilter = 'none';
        }
    });
}

// Parallax Effect for Hero Section
function initParallaxEffect() {
    const hero = document.querySelector('.hero-section');
    
    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        const rate = scrolled * -0.5;
        
        if (hero) {
            hero.style.transform = `translateY(${rate}px)`;
        }
    });
}

// Card Hover Effects
document.querySelectorAll('.feature-card, .tech-card, .about-card, .usage-step').forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-10px) scale(1.02)';
    });

    card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0) scale(1)';
    });
});

// Innovation Card Hover Effects
document.querySelectorAll('.innovation-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-5px)';
        this.style.borderLeftColor = 'var(--accent-red)';
    });

    card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0)';
        this.style.borderLeftColor = 'var(--primary-green)';
    });
});

// Statistics Card Hover Effects
document.querySelectorAll('.stat-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
        const icon = this.querySelector('.stat-icon');
        if (icon) {
            icon.style.transform = 'scale(1.2) rotate(10deg)';
            icon.style.opacity = '0.6';
        }
    });
    
    card.addEventListener('mouseleave', function() {
        const icon = this.querySelector('.stat-icon');
        if (icon) {
            icon.style.transform = 'scale(1) rotate(0deg)';
            icon.style.opacity = '0.3';
        }
    });
});

// Download Button Click Tracking
document.querySelectorAll('.download-buttons .btn').forEach(button => {
    button.addEventListener('click', function(e) {
        // Add click animation
        this.style.transform = 'scale(0.95)';
        setTimeout(() => {
            this.style.transform = 'scale(1)';
        }, 150);

        // Track download attempt
        console.log('Download button clicked:', this.textContent.trim());

        // Handle APK download
        if (this.getAttribute('href') === 'araloug.apk') {
            // APK download will proceed naturally with download attribute
            console.log('Araloug APK download initiated');
        } else if (this.getAttribute('href') === '#') {
            // Prevent default for placeholder buttons
            e.preventDefault();
            alert('Coming soon! Download the APK file for now.');
        }
    });
});

// Social Links Hover Effects
document.querySelectorAll('.social-links a').forEach(link => {
    link.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-3px) scale(1.1)';
    });
    
    link.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0) scale(1)';
    });
});

// Loading Screen (Optional)
function showLoadingScreen() {
    const loadingHTML = `
        <div id="loading-screen" style="
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #1B5E20 0%, #2E7D32 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            color: white;
            font-family: 'Poppins', sans-serif;
        ">
            <div style="text-align: center;">
                <div style="
                    width: 50px;
                    height: 50px;
                    border: 3px solid rgba(255,255,255,0.3);
                    border-top: 3px solid white;
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                    margin: 0 auto 20px;
                "></div>
                <h3>Araloug</h3>
                <p>Loading amazing content...</p>
            </div>
        </div>
        <style>
            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        </style>
    `;
    
    document.body.insertAdjacentHTML('afterbegin', loadingHTML);
    
    // Hide loading screen after page loads
    window.addEventListener('load', function() {
        const loadingScreen = document.getElementById('loading-screen');
        if (loadingScreen) {
            loadingScreen.style.opacity = '0';
            setTimeout(() => {
                loadingScreen.remove();
            }, 500);
        }
    });
}

// Initialize loading screen
// showLoadingScreen();

// Easter Egg: Konami Code
let konamiCode = [];
const konamiSequence = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65]; // Up Up Down Down Left Right Left Right B A

document.addEventListener('keydown', function(e) {
    konamiCode.push(e.keyCode);
    
    if (konamiCode.length > konamiSequence.length) {
        konamiCode.shift();
    }
    
    if (konamiCode.join(',') === konamiSequence.join(',')) {
        // Easter egg activated!
        document.body.style.animation = 'rainbow 2s infinite';
        setTimeout(() => {
            document.body.style.animation = '';
            alert('🇩🇿 You found the secret! Welcome to Araloug! 🇩🇿');
        }, 2000);
    }
});

// Add rainbow animation for easter egg
const style = document.createElement('style');
style.textContent = `
    @keyframes rainbow {
        0% { filter: hue-rotate(0deg); }
        100% { filter: hue-rotate(360deg); }
    }
`;
document.head.appendChild(style);
