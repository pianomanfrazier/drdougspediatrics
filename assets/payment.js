// see https://stackoverflow.com/questions/105034/how-do-i-create-a-guid-uuid/2117523#2117523
function uuidv4() {
    return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c =>
        (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
}

const LAMBDA_ENDPOINT = 'http://localhost:9000/payment'; // TODO: change to production URL
const STRIPE_PUBLISHABLE_KEY = 'pk_test_51MAx11Ec8kJgDWMnTVQ98MVsQBzf37f7bL0PnoW4APs6y9LMUhg8sfFyYjoVIQit5xhK7ylUoEoyozzzddzAJksj00asdMnQKa'

const amount = 1000; // TODO: get amount from user
const description = 'Payment for invoice #12345'; // TODO: get invoice number from user

const $messageBox = document.getElementById('message-box');
const $button = document.getElementById('payment-button');

const handler = StripeCheckout.configure({
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
          amount,
          idempotency_key: uuidv4(),
          description
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

$button.addEventListener('click', () => {

  handler.open({
    amount,
    name: "Dr. Doug's Pediatric Dentistry",
    description
  });
});