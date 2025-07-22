# Araloug - Website Documentation

This is the official statistics and promotional website for the "Araloug" Flutter application. The website showcases the app's features, statistics, and provides download links.

## 🌟 Website Features

### 📱 Mobile-First Design
- **Responsive Layout**: Optimized for all screen sizes (mobile, tablet, desktop)
- **Bootstrap 5**: Modern CSS framework for consistent styling
- **Touch-Friendly**: Large buttons and easy navigation on mobile devices

### 🎨 Visual Design
- **Algerian Theme**: Uses official Algerian flag colors (Green #1B5E20, Red #C62828)
- **Google Fonts**: Beautiful typography with Poppins and Amiri fonts
- **Font Awesome Icons**: Professional iconography throughout the site
- **Smooth Animations**: Engaging hover effects and transitions

### ✨ Interactive Elements
- **Animated Hero Section**: Typing animation with rotating text
- **Scroll Animations**: Elements fade in as you scroll
- **Counter Animation**: Statistics numbers count up when visible
- **Parallax Effects**: Subtle background movement on scroll

### 📊 Statistics Section
Interactive counters showing:
- **8** Learning Levels
- **40+** Conversation Categories  
- **4** Regional Dialects
- **6** Cultural Categories

### 📲 Download Section
- **App Store Buttons**: Styled download buttons for iOS and Android
- **QR Code**: Automatically generated QR code for easy mobile downloads
- **System Requirements**: Clear compatibility information

## 🛠️ Technical Stack

### Frontend Technologies
- **HTML5**: Semantic markup structure
- **CSS3**: Modern styling with custom properties and animations
- **JavaScript (ES6+)**: Interactive functionality and animations
- **Bootstrap 5**: Responsive grid system and components

### External Libraries
- **Bootstrap 5.3.0**: CSS framework and JavaScript components
- **Font Awesome 6.4.0**: Icon library
- **Google Fonts**: Poppins and Amiri font families
- **QRCode.js 1.5.3**: QR code generation library

### Key Features
- **100% Client-Side**: No server required, works with static hosting
- **SEO Optimized**: Proper meta tags and semantic HTML
- **Accessibility**: ARIA labels and keyboard navigation support
- **Performance**: Optimized images and minified resources

## 📁 File Structure

```
docs/
├── index.html          # Main HTML file
├── styles.css          # Custom CSS styles
├── script.js           # JavaScript functionality
└── README.md           # This documentation file
```

## 🚀 Getting Started

### Local Development
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd inalgeriawesay/docs
   ```

2. **Open in browser**
   - Simply open `index.html` in your web browser
   - Or use a local server for better development experience:
   ```bash
   # Using Python
   python -m http.server 8000
   
   # Using Node.js
   npx serve .
   
   # Using PHP
   php -S localhost:8000
   ```

3. **View the website**
   - Open `http://localhost:8000` in your browser

### Deployment Options
- **GitHub Pages**: Push to `gh-pages` branch
- **Netlify**: Drag and drop the `docs` folder
- **Vercel**: Connect your repository
- **Firebase Hosting**: Use Firebase CLI
- **Any Static Host**: Upload files to web server

## 🎨 Customization

### Colors
The website uses CSS custom properties for easy theming:
```css
:root {
    --primary-green: #1B5E20;    /* Algerian flag green */
    --accent-red: #C62828;       /* Algerian flag red */
    --background-light: #F5F5F5; /* Light background */
    --text-primary: #212121;     /* Dark text */
    --text-secondary: #757575;   /* Gray text */
}
```

### Typography
- **Headers**: Poppins font, bold weights
- **Body Text**: Poppins font, regular weight
- **Arabic Text**: Amiri font for cultural authenticity

### Animations
- **Typing Effect**: Hero section text animation
- **Fade In**: Scroll-triggered animations
- **Hover Effects**: Interactive element responses
- **Counter Animation**: Number counting effects

## 📱 Mobile Optimization

### Responsive Breakpoints
- **Mobile**: < 576px
- **Tablet**: 576px - 768px
- **Desktop**: > 768px

### Mobile Features
- **Touch Gestures**: Optimized for touch interaction
- **Readable Text**: Appropriate font sizes for mobile
- **Fast Loading**: Optimized images and resources
- **Offline Capable**: Works without internet connection

## 🔧 Browser Support

### Supported Browsers
- **Chrome**: 60+
- **Firefox**: 60+
- **Safari**: 12+
- **Edge**: 79+
- **Mobile Browsers**: iOS Safari 12+, Chrome Mobile 60+

### Progressive Enhancement
- **Core Functionality**: Works in all browsers
- **Enhanced Features**: Modern browsers get animations
- **Fallbacks**: Graceful degradation for older browsers

## 📈 Performance

### Optimization Features
- **Lazy Loading**: Images load when needed
- **Minified Resources**: Compressed CSS and JavaScript
- **CDN Resources**: Fast loading from global CDNs
- **Efficient Animations**: GPU-accelerated transforms

### Loading Speed
- **First Paint**: < 1 second
- **Interactive**: < 2 seconds
- **Fully Loaded**: < 3 seconds

## 🌍 Internationalization

### Current Languages
- **English**: Primary language
- **Arabic Elements**: Cultural authenticity

### Future Enhancements
- **Arabic Version**: Full RTL support
- **French Version**: Algeria's second language
- **Tamazight Elements**: Berber language integration

## 🤝 Contributing

### Development Guidelines
1. **Code Style**: Follow existing patterns
2. **Mobile First**: Design for mobile, enhance for desktop
3. **Accessibility**: Maintain WCAG 2.1 AA compliance
4. **Performance**: Keep loading times minimal

### Pull Request Process
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on multiple devices
5. Submit a pull request

## 📞 Support

### Contact Information
- **Email**: contact@araloug.com
- **Website**: [www.araloug.com](https://www.araloug.com)
- **GitHub**: [github.com/araloug](https://github.com/araloug)

### Issues and Bugs
- Report issues on GitHub
- Include browser and device information
- Provide steps to reproduce

---

**Made with ❤️ for preserving and sharing Algerian culture and language** 🇩🇿
