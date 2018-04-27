var RegistrationsController = Paloma.controller('Users/Registrations');

RegistrationsController.prototype.new = function() {
  let handle = document.getElementById('handle');
  let errorHandle = document.getElementById('error-handle');
  let email = document.getElementById('email');
  let errorEmail = document.getElementById('error-email');
  let password = document.getElementById('password');
  let errorPassword = document.getElementById('error-password');
  let confirmation = document.getElementById('confirmation');
  let errorConfirmation = document.getElementById('error-confirmation');

  function updateClass(element, newClass) {
    if (!element.classList.contains(newClass)) {
      element.className = ''; // clear class list
      element.classList.add(newClass);
    }
  }

  function checkHandleField(e) {
    let el = e.target;
    let error_message;
    if (/[^a-zA-Z0-9\-_]/.test(el.value)) {
      updateClass(el, 'invalid');
      error_message = 'Invalid character.';
      errorHandle.innerHTML = error_message;
      return;
    }
    if (el.value == '') {
      updateClass(el, 'invalid');
      error_message = 'Can not be blank.';
      errorHandle.innerHTML = error_message;
      return;
    }
    if (el.value.length > 20) {
      updateClass(el, 'invalid');
      error_message = 'Too long.';
      errorHandle.innerHTML = error_message;
      return;
    }
    updateClass(el, 'valid');
    errorHandle.innerHTML = '';
  }

  const VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+/i;
  function checkEmailField(e) {
    let el = e.target;
    let error_message;
    if (!VALID_EMAIL_REGEX.test(el.value)) {
      updateClass(el, 'invalid');
      error_message = 'Invalid email.';
      errorEmail.innerHTML = error_message;
      return;
    }
    updateClass(el, 'valid');
    errorEmail.innerHTML = '';
  }

  function checkPasswordField(e) {
    let el = e.target;
    let error_message;
    if (el.value != confirmation.value) {
      updateClass(confirmation, 'invalid');
      error_message = 'Does not match password.';
      errorConfirmation.innerHTML = error_message;
    }

    if (el.value.length > 126) {
      updateClass(el, 'invalid');
      error_message = 'Really? Too long.';
      errorPassword.innerHTML = error_message;
      return;
    }
    if (el.value.length < 6) {
      updateClass(el, 'invalid');
      error_message = 'Too short!.';
      errorPassword.innerHTML = error_message;
      return;
    }
    updateClass(el, 'valid');
    errorPassword.innerHTML = '';
  }

  function checkConfirmation(e) {
    let el = e.target;
    let error_message;
    if (el.value != password.value) {
      updateClass(el, 'invalid');
      error_message = 'Does not match password.';
      errorConfirmation.innerHTML = error_message;
      return;
    }
    updateClass(el, 'valid');
    errorConfirmation.innerHTML = '';
  }

  handle.addEventListener('input', checkHandleField);
  email.addEventListener('input', checkEmailField);
  password.addEventListener('input', checkPasswordField);
  confirmation.addEventListener('input', checkConfirmation);
};
