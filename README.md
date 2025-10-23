## Nexure Notify

## A easy to use Notify Script for all FiveM Frameworks

## Feature

- Clean and modern UI
- Multiple notification types (success, warning, info, error, bank, police, EMS, mechanic, fire)
- Optional sound support
- Easily integrated with ESX or your own scripts
- Display notifications above the minimap

## Usage

## Using the Export
```lua
exports['nexure_notify']:ShowNotification({
    title = 'Success!',
    message = 'Action completed successfully',
    type = 'success',      -- success, error, warning, info, bank, police, EMS, mechanic, fire
    duration = 5000,        -- duration in milliseconds
    sound = true            -- optional, defaults to false
})
```

## Using the Event (for ESX or Legacy Scripts)
```lua
TriggerEvent('nexure_notify:showNotification', {
    title = 'Bank',
    message = 'You deposited $5000',
    type = 'bank',
    duration = 6000,
    sound = true
})
```

## Position

Notifications are displayed above the minimap by default.

CSS snippet:
```css
#notification-container {
    position: fixed;
    background: transparent;
    bottom: 245px;
    left: 23px;
    width: 340px;
    z-index: 9999;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.notification {
    background: rgba(17, 24, 39, 0.75);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 16px;
    padding: 18px 20px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3),
                0 0 0 1px rgba(255, 255, 255, 0.05) inset;
    display: flex;
    align-items: flex-start;
    gap: 16px;
    position: relative;
    overflow: hidden;
    animation: slideIn 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
    transition: all 0.3s ease;
}
```

## Example Notifications

-- Success
```lua
exports['nexure_notify']:ShowNotification({
    title = 'Success!',
    message = 'Action completed successfully',
    type = 'success',
    duration = 5000
})
```

-- Bank
```lua
TriggerEvent('nexure_notify:showNotification', {
    title = 'Bank',
    message = 'You deposited $5000',
    type = 'bank',
    duration = 6000,
    sound = true
})
```

## 💙 Contributors
<a href="https://github.com/Nexure-Dev/nexure_notify/graphs/contributors" target="_blank"><img src="https://contrib.rocks/image?repo=Nexure-Dev/nexure_notify&columns=18" alt="contributors"></a>
