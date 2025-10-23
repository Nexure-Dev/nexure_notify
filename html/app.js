const container = document.getElementById('notification-container');
const activeNotifications = new Map();
const soundEnabled = true;

function playSound() {
    if (!soundEnabled) return;
    const audio = new Audio('https://cdnjs.cloudflare.com/ajax/libs/ion-sound/3.0.7/sounds/button_tiny.mp3');
    audio.volume = 0.3;
    audio.play().catch(() => {});
}

function createNotification(data) {
    playSound();

    const notif = document.createElement('div');
    notif.className = 'notification';
    notif.id = `notification-${data.id}`;
    
    const iconBg = data.color;
    
    notif.innerHTML = `
        <div class="notification-icon" style="background: linear-gradient(135deg, ${iconBg}33, ${iconBg}11); color: ${data.color};">
            <i class="fas ${data.icon}"></i>
        </div>
        <div class="notification-content">
            <div class="notification-title">${data.title}</div>
            <div class="notification-message">${data.message}</div>
        </div>
        <button class="notification-close" onclick="removeNotification(${data.id})">
            <i class="fas fa-times"></i>
        </button>
        <div class="notification-progress" style="background: ${data.color}; width: 100%;"></div>
    `;

    notif.style.borderColor = data.color;
    notif.style.background = `linear-gradient(135deg, rgba(17, 24, 39, 0.85), rgba(17, 24, 39, 0.75)), 
                              radial-gradient(circle at top right, ${iconBg}15, transparent 70%)`;
    notif.style.boxShadow = `0 8px 32px rgba(0, 0, 0, 0.3), 
                             0 0 0 1px ${iconBg}30 inset,
                             0 0 20px ${iconBg}20`;

    const beforeStyle = document.createElement('style');
    beforeStyle.innerHTML = `
        #notification-${data.id}::before {
            background: ${data.color};
        }
        #notification-${data.id}::after {
            background: ${data.color};
        }
    `;
    document.head.appendChild(beforeStyle);

    container.insertBefore(notif, container.firstChild);
    
    const progress = notif.querySelector('.notification-progress');
    progress.style.transition = `width ${data.duration}ms linear`;
    
    requestAnimationFrame(() => {
        progress.style.width = '0%';
    });

    const timeout = setTimeout(() => {
        removeNotification(data.id);
    }, data.duration);

    activeNotifications.set(data.id, {
        element: notif,
        timeout: timeout,
        style: beforeStyle
    });
}

function removeNotification(id) {
    const notifData = activeNotifications.get(id);
    if (!notifData) return;

    clearTimeout(notifData.timeout);
    notifData.element.classList.add('removing');

    setTimeout(() => {
        if (notifData.element.parentNode) {
            notifData.element.parentNode.removeChild(notifData.element);
        }
        if (notifData.style && notifData.style.parentNode) {
            notifData.style.parentNode.removeChild(notifData.style);
        }
        activeNotifications.delete(id);
    }, 400);
}

window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.action === 'showNotification') {
        createNotification(data);
    }
});