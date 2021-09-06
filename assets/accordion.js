
function toggle(id, btn) {
    const BUTTONCLASS = "accordion-btn-active"
    const CLASSNAME = "accordion-visible"
    let el = document.getElementById(id)
    let els = [...document.getElementsByClassName("accordion-content")]
    let btns = [...document.getElementsByClassName("accordion-btn")]

    btnContains = btn.classList.contains(BUTTONCLASS)
    btns.forEach(e => {
        e.classList.remove(BUTTONCLASS)
    })
    if (btnContains) {
        btn.classList.remove(BUTTONCLASS)
    } else {
        btn.classList.add(BUTTONCLASS)
    }


    contains = el.classList.contains(CLASSNAME)
    els.forEach(e => {
        e.classList.remove(CLASSNAME)
    });
    if (contains) {
        el.classList.remove(CLASSNAME)
    } else {
        el.classList.add(CLASSNAME)
    }
}