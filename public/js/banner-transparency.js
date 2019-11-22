window.addEventListener('scroll', (event) => {
  var scrollPos = window.scrollY || window.scrollTop || document.getElementsByTagName("html")[0].scrollTop
  if (scrollPos > 500) {
    console.log(scrollPos)
    document.querySelector('.navbar').style.backgroundColor = "#FAFAFA"
    document.querySelectorAll('.purple-li a').forEach((item) => {item.style.color = "#565FBD"})
    } else {
    document.querySelector('.navbar').style.backgroundColor = ""
    document.querySelectorAll('.purple-li a').forEach((item) => {item.style.color = "white"})
  };
})
