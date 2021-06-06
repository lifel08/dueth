import { SLIDEPAGE } from '../plugins/slidepage';

const initSlidePage = () => {
  if (document.querySelector('.app')) {
  var sp = new SLIDEPAGE({
    el: ".app",
    repeat: true,         // default: false
    realNumber: true,     // default: false
    direction: "x",       // default: x
    display: 'block',     // default: block
    transition: 300,      // default: 250
    forceDirection: true  // default: true
  });
  window.sp = sp;
  };
};
export { initSlidePage };
