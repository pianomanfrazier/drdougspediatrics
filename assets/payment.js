// see https://stackoverflow.com/questions/105034/how-do-i-create-a-guid-uuid/2117523#2117523
function uuidv4() {
    return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c =>
        (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
}

// DEV API URL
const LAMBDA_ENDPOINT = 'http://localhost:9000/payment';
// PRODUCTION API URL
// const LAMBDA_ENDPOINT = 'https://drdoug.netlify.app/.netlify/functions/payment';
const STRIPE_PUBLISHABLE_KEY = 'pk_test_51MAx11Ec8kJgDWMnTVQ98MVsQBzf37f7bL0PnoW4APs6y9LMUhg8sfFyYjoVIQit5xhK7ylUoEoyozzzddzAJksj00asdMnQKa'

let amount = -1000; // TODO: get amount from user
let invoiceNumber = 000;
const description = (invoiceNumber) => 'Payment for invoice #' + invoiceNumber; // TODO: get invoice number from user

const $messageBox = document.getElementById('message-box');


const $paymentModal = document.getElementById('payment-modal');
const $paymentButton = document.getElementById('payment-button');
const $modalBtn = document.getElementById('modal-button');
const $closeBtn = document.getElementById('close-button');

const $invoiceNumber = document.getElementById('invoice-number');
const $invoiceAmount = document.getElementById('invoice-amount');

const handler = (invoiceNumber, invoiceAmount) => StripeCheckout.configure({
  key: STRIPE_PUBLISHABLE_KEY, 
  image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
  locale: 'auto',
  closed: function () {
  },
  token: async function(token) {

    let response, data;

    try {
      response = await fetch(LAMBDA_ENDPOINT, {
        method: 'POST',
        body: JSON.stringify({
          token,
          amount: invoiceAmount,
          idempotency_key: uuidv4(),
          description: description(invoiceNumber)
        }),
        headers: new Headers({
          'Content-Type': 'application/json'
        })
      });

      data = await response.json();
    } catch (error) {
      console.error(error.message);
      return;
    }

    let message = typeof data === 'object' && data.status === 'succeeded'
      ? 'Charge was successful!'
      : 'Charge failed.'
    $messageBox.querySelector('h2').innerHTML = message;

    console.log(data);
  }
});

$modalBtn.addEventListener('click', () => {
  $paymentModal.classList.add('active');
});

$invoiceNumber.addEventListener('input', (evt) => {
  const value = evt.target.value;
  console.log(evt.target.value);
  invoiceNumber = value;

})
$invoiceAmount.addEventListener('input', (evt) => {
  const value = evt.target.value;
  console.log(evt.target.value);
  amount = value * 100;
})
$closeBtn.addEventListener('click', () => {
  $paymentModal.classList.remove('active');
});

$paymentButton.addEventListener('click', () => {
  $paymentModal.classList.remove('active');

  handler(invoiceNumber, amount).open({
    amount: amount,
    name: "Dr. Doug's Pediatric Dentistry",
    description: description(invoiceNumber)
  });
});