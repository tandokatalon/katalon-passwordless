// Custom JavaScript for Katalon Keycloak theme - Bootstrap 5 compatible

(function() {
    'use strict';

    // Initialize theme when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        initializeTheme();
    });

    function initializeTheme() {
        initializeAlerts();
        initializeFocus();
        initializeFormValidation();
        initializeDropdowns();
        initializeTooltips();
    }

    // Auto-hide alerts after 5 seconds with better error handling
    function initializeAlerts() {
        const alerts = document.querySelectorAll('.alert:not(.alert-permanent)');
        alerts.forEach(function(alert) {
            // Don't auto-hide error alerts
            if (!alert.classList.contains('alert-danger')) {
                setTimeout(function() {
                    try {
                        const bsAlert = new bootstrap.Alert(alert);
                        if (bsAlert) {
                            bsAlert.close();
                        }
                    } catch (e) {
                        // Fallback if Bootstrap alert fails
                        alert.style.transition = 'opacity 0.5s ease';
                        alert.style.opacity = '0';
                        setTimeout(function() {
                            if (alert.parentNode) {
                                alert.parentNode.removeChild(alert);
                            }
                        }, 500);
                    }
                }, 5000);
            }
        });
    }

    // Smart focus management
    function initializeFocus() {
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');
        const firstNameInput = document.getElementById('firstName');
        
        // Focus logic based on form type and field state
        if (usernameInput && passwordInput) {
            // Login form
            if (usernameInput.value === '' || usernameInput.hasAttribute('autofocus')) {
                usernameInput.focus();
            } else {
                passwordInput.focus();
            }
        } else if (firstNameInput) {
            // Registration form
            firstNameInput.focus();
        } else if (usernameInput) {
            // Other forms with username
            usernameInput.focus();
        }
    }

    // Form validation enhancements
    function initializeFormValidation() {
        const forms = document.querySelectorAll('form');
        forms.forEach(function(form) {
            // Add Bootstrap validation classes on submit
            form.addEventListener('submit', function(event) {
                const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
                inputs.forEach(function(input) {
                    if (!input.value.trim()) {
                        input.classList.add('is-invalid');
                    } else {
                        input.classList.remove('is-invalid');
                        input.classList.add('is-valid');
                    }
                });
            });

            // Real-time validation feedback
            const inputs = form.querySelectorAll('input, select, textarea');
            inputs.forEach(function(input) {
                input.addEventListener('blur', function() {
                    if (input.hasAttribute('required') && !input.value.trim()) {
                        input.classList.add('is-invalid');
                        input.classList.remove('is-valid');
                    } else if (input.value.trim()) {
                        input.classList.remove('is-invalid');
                        input.classList.add('is-valid');
                    }
                });

                input.addEventListener('input', function() {
                    if (input.classList.contains('is-invalid') && input.value.trim()) {
                        input.classList.remove('is-invalid');
                    }
                });
            });
        });
    }

    // Initialize Bootstrap dropdowns
    function initializeDropdowns() {
        const dropdownElements = document.querySelectorAll('[data-bs-toggle="dropdown"]');
        dropdownElements.forEach(function(element) {
            try {
                new bootstrap.Dropdown(element);
            } catch (e) {
                console.warn('Failed to initialize dropdown:', e);
            }
        });
    }

    // Initialize Bootstrap tooltips if any exist
    function initializeTooltips() {
        const tooltipElements = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        tooltipElements.forEach(function(element) {
            try {
                new bootstrap.Tooltip(element);
            } catch (e) {
                console.warn('Failed to initialize tooltip:', e);
            }
        });
    }

    // Enhanced password visibility toggle (if needed)
    function initializePasswordToggle() {
        const passwordToggles = document.querySelectorAll('.password-toggle');
        passwordToggles.forEach(function(toggle) {
            toggle.addEventListener('click', function() {
                const targetId = toggle.getAttribute('data-target');
                const targetInput = document.getElementById(targetId);
                
                if (targetInput) {
                    if (targetInput.type === 'password') {
                        targetInput.type = 'text';
                        toggle.classList.remove('fa-eye');
                        toggle.classList.add('fa-eye-slash');
                    } else {
                        targetInput.type = 'password';
                        toggle.classList.remove('fa-eye-slash');
                        toggle.classList.add('fa-eye');
                    }
                }
            });
        });
    }

    // Utility function to show/hide loading states
    window.showLoading = function(button) {
        if (button) {
            button.disabled = true;
            button.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Loading...';
        }
    };

    window.hideLoading = function(button, originalText) {
        if (button) {
            button.disabled = false;
            button.innerHTML = originalText || 'Submit';
        }
    };

})();