//filter
const filter = document.querySelectorAll('.btn_goods_nav');
filter.forEach(button => {
    button.addEventListener('click', startFilter)
})
function startFilter(e){
    const currentButton = e.currentTarget.dataset['f'];
    const filterTarget = document.querySelectorAll('.good_container');
    filterTarget.forEach( elem => {
        elem.style.display = "flex";
        if (!elem.classList.contains(currentButton) && currentButton !== 'all') {
            elem.style.display = "none";
        }
    })
}

