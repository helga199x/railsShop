showBtn = document.querySelectorAll('.show_btn');
backBtn = document.querySelectorAll('.back_btn');
showBtn.forEach(elem => {
    elem.addEventListener('click', showForm);
})
backBtn.forEach(elem =>{
    elem.addEventListener('click', back);
})

function showForm(e) {
    const currentButton = e.currentTarget.dataset['i'];
    li = document.querySelectorAll(".good"+currentButton)[0];
    li.style.display = 'none';
    form = document.querySelectorAll(".container_form"+currentButton)[0];
    form.style.display = 'flex';
}


function back(e){
    const currentButton = e.currentTarget.dataset['i'];
    li = document.querySelectorAll(".good"+currentButton)[0];
    li.style.display = 'flex';
    form = document.querySelectorAll(".container_form"+currentButton)[0];
    form.style.display = 'none';
}