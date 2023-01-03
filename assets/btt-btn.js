// BACK TO TOP BUTTON
const btn = document.getElementById("btt-btn")

var myScrollFunc = function() {
    const y = window.scrollY;
    if (y >= 800) {
      btn.className = "show"
    } else {
      btn.className = "hide"
    }
  };
  
window.addEventListener("scroll", myScrollFunc);