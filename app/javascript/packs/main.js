// create an array of goods
let goodList =[]
let iG = document.querySelectorAll(".idG").length;
for (let i = 0; i < iG; i++){
    const imgG = document.querySelectorAll(".imgG")[i].src;
    const nameG = document.querySelectorAll(".nameG")[i].textContent;
    const priceG = document.querySelectorAll(".priceG")[i].textContent;
    const weightG = document.querySelectorAll(".weightG")[i].textContent;
    const idG = document.querySelectorAll(".idG")[i].id;
    const dbId = document.querySelectorAll(".dbId")[i].textContent;
    goodList.push({id: idG, dbId: dbId, name: nameG, price: priceG, weight: weightG, img: imgG, amount: 0})
}

// filter
const filter = document.querySelectorAll('.btn_goods_nav');
filter.forEach(button => {
    button.addEventListener('click', startFilter)
})
function startFilter(e){
    const currentButton = e.currentTarget.dataset['f'];
    const filterTarget = document.querySelectorAll('.good_container');
    filterTarget.forEach( elem => {
        elem.style.display = "";
        if (!elem.classList.contains(currentButton) && currentButton !== 'all') {
            elem.style.display = "none";
        }
    })
}


// hide/show basket
const bask_icon = document.getElementsByClassName('basket_icon')[0];
bask_icon.addEventListener('click', showBasket);
const bask = document.getElementsByClassName('basket')[0];
function showBasket (){
    bask.style.display = "flex";
}
window.onclick = function(e) {
    if (e.target == bask) {
        bask.style.display = "none";
    }
}

function renderIconBasket() {
    const iconBas = document.getElementsByClassName("basket_amount")[0];
    iconBas.remove();
    const iconBasHTML = `
    <div class="basket_amount">${goodList[i].amount}</div>
    `;
    const PlaceInIcon = document.getElementsByClassName("basket_container")[0];
    PlaceInIcon.insertAdjacentHTML('afterbegin', iconBasHTML);
}

// add goods to basket
const goodsBtn = document.querySelectorAll('.btn');
goodsBtn.forEach(button => {
    button.addEventListener('click', AddGoodToBacket)
})

function AddGoodToBacket(e) {
    const currentButton = e.currentTarget.id;
    goodList.forEach(ourGood => {
        if (currentButton == ourGood.id && goodList[currentButton-1].amount < 1) {
            goodList[currentButton-1].amount++;
            renderBasket(goodList[currentButton-1]);
            renderBasketTot(goodList[currentButton-1]);
            renderIconBasked(goodList[currentButton-1].id);
            messageGood(currentButton);
            btnOrdToMinPlus(currentButton);
        }
        else if (currentButton == ourGood.id){
            goodList[currentButton-1].amount++;
            renderBasketTot(goodList[currentButton-1]);
            renderIconBasked(goodList[currentButton-1].id);
            messageGood(currentButton);
        }
    })
}


//message about add
function messageGood(id){
    const messageHTML = `
    <div class="message_basket">
    <h2 class="message_basket">Added: ${goodList[id-1].name}</h2>
    </div>
    `
    const placeIn = document.getElementsByClassName('basket_amount')[0];
    placeIn.insertAdjacentHTML('afterend', messageHTML);
    function deleteF(){
        document.getElementsByClassName('message_basket')[0].remove();
    }
    setTimeout(deleteF, 1000);
}


//add plus and minus on main page
function btnOrdToMinPlus(idBtn){
    const orderBtn = document.getElementById(idBtn);
    const mainPlusMinBtnHTML = `
        <div class="mainPlusMinBtn${goodList[idBtn-1].id}">
                <button class="btn minus mainP${goodList[idBtn-1].id}" data-a="${orderBtn.id}">-</button>
                <div class="good_btns mainT${goodList[idBtn-1].id}" data-a="${goodList[idBtn-1].id}">
                    ${goodList[idBtn-1].amount}
                </div>
                <button class="btn plus mainP" data-a="${orderBtn.id}">+</button>
        </div>
    `
    orderBtn.insertAdjacentHTML('beforebegin', mainPlusMinBtnHTML);
    orderBtn.remove();
}


//add plus and minus functions
document.onclick = event => {
    if (event.target.classList.contains('plus')) {
        plusGoods(event.target.dataset['a']);
    }
    if (event.target.classList.contains('minus')) {
        minusGoods(event.target.dataset['a']);
    }
}

function plusGoods(data) {
    goodList[data-1].amount++;
    renderBasketTot(goodList[data-1]);
    renderIconBasked(goodList[data-1].id);
}

function minusGoods(data) {
    if (goodList[data-1].amount == 1){
        goodList[data-1].amount--;
        const currBtn = document.querySelectorAll(`[data-a="${data}"]`)[0];
        currBtn.closest('.goodInBacket').remove();
        const classMainPNM ="mainPlusMinBtn" + goodList[data-1].id;
        const mainPMB = document.getElementsByClassName(classMainPNM)[0];
        const btnOrderHTML = `
        <button class="btn" id="${goodList[data-1].id}">Order</button>
        `
        mainPMB.insertAdjacentHTML('beforebegin', btnOrderHTML);
        mainPMB.remove();
        const goodsBtn2 = document.querySelectorAll('.btn');
        goodsBtn2.forEach(button => {
            button.addEventListener('click', AddGoodToBacket)
        })
        renderIconBasked(goodList[data-1].id);
        let tAm = goodList.reduce((total, good) => {
            return total + (good.amount * good.price)
        }, 0);
        if (tAm == 0) {
            renderEmptyTotal();
        }
        else {
            renderTotalPrice();
        }
    }
    else{
        goodList[data-1].amount--;
        renderBasketTot(goodList[data-1]);
        renderIconBasked(goodList[data-1].id);
    }
}


//render functions
function renderBasket(crnt_btn){
    const rowGoodHTLM = `
            <div class="goodInBacket">
                <div><img src="${crnt_btn.img}" width="50" height="50"></div>
                <div>${crnt_btn.name}</div>
                <div class="weight_g${crnt_btn.id}">Weight of product: ${crnt_btn.weight}</div>
                <div class="tot_good${crnt_btn.id}">Amount: ${crnt_btn.amount}</div>
                <div class="price_g${crnt_btn.id}">Price: ${crnt_btn.price}$</div>
                <div>
                    <button class="btn minus" data-a ="${crnt_btn.id}">-</button>
                    <button class="btn plus" data-a ="${crnt_btn.id}">+</button>
                </div>
            </div>`;
            const placeIn = document.getElementsByClassName('start_bar')[0];
            placeIn.insertAdjacentHTML('beforeend', rowGoodHTLM);


}

function renderBasketTot(tot){
    const totGoods = document.getElementsByClassName("tot_good"+ tot.id)[0];
    totGoods.remove();
    const totPrice = document.getElementsByClassName("price_g"+ tot.id)[0];
    totPrice.remove();
    const totGoodsHTML = `
    <div class="tot_good${tot.id}">Amount: ${tot.amount}</div>
    <div class="price_g${tot.id}">Price: ${tot.price*tot.amount}$</div>
    `;
    const PlaceIn = document.getElementsByClassName("weight_g"+ tot.id)[0];
    PlaceIn.insertAdjacentHTML('afterend', totGoodsHTML);
    renderTotalPrice();
}

function renderTotalPrice(){
    let amon = goodList.reduce((total, good) => {
        return total + (good.amount * good.price)
    }, 0);
    const finalPriceLabel = document.getElementsByClassName("final_price_label")[0];
    finalPriceLabel.remove();
    const finPriceHTML = `
    <label class="final_price_label">Total price: ${amon}$ </label>
    `;
    const PlaceInT = document.getElementsByClassName("container_form")[0];
    PlaceInT.insertAdjacentHTML('beforeend', finPriceHTML);
}

function renderEmptyTotal(){
    const finalPrice = document.getElementsByClassName("final_price_label")[0];
    finalPrice.remove();
    const finPriceHTML = `
    <label class="final_price_label">Total price: 0$</label>
    `;
    const PlaceInT = document.getElementsByClassName("end_bar_btn")[0];
    PlaceInT.insertAdjacentHTML('afterend', finPriceHTML);
}

function renderIconBasked(idBtn){
    let amonIcon = goodList.reduce((total, good) => {
        return total + good.amount
    }, 0);
    const iconBas = document.getElementsByClassName("basket_amount")[0];
    iconBas.remove();
    const iconBasHTML = `
    <div class="basket_amount">${amonIcon}</div>
    `;
    const PlaceInIcon = document.getElementsByClassName("basket_container")[0];
    PlaceInIcon.insertAdjacentHTML('afterbegin', iconBasHTML);

    //render amount on main page
    const orderButton = document.getElementById(idBtn);
    if (orderButton == null){
        mainAmountHTML = `
        <div class="good_btns mainT${goodList[idBtn-1].id}" data-a="${goodList[idBtn-1].id}">
            ${goodList[idBtn-1].amount}
        </div>
        `
        const dsf = "good_btns mainT" + goodList[idBtn-1].id;
        document.getElementsByClassName(dsf)[0].remove();
        const dfs = "btn minus mainP" + goodList[idBtn-1].id;
        const PlaceInT = document.getElementsByClassName(dfs)[0];
        PlaceInT.insertAdjacentHTML('afterend', mainAmountHTML);
    }
}

//add button-to-top when scroll
window.onscroll = function() {
    showBtnScroll();
};
const scrollBtn = document.getElementsByClassName('scrollBtn')[0];
function showBtnScroll() {
    let scrollPosition = document.documentElement.getBoundingClientRect().top;
    if (scrollPosition <= (-100)) {
        scrollBtn.style.display = 'flex';
    }
    else {
        scrollBtn.style.display = 'none';
    }
}
scrollBtn.onclick = () => {
    window.scrollTo(0,0);
}

//add discription show onclick 

const image = document.querySelectorAll('.imgG');
image.forEach(img => {
    img.addEventListener('click', showDiscription);
})

const discription = document.querySelectorAll('.discriptionG');
discription.forEach(disc => {
    disc.addEventListener('click', showImage);
})


function showDiscription(e){
    img = e.currentTarget;
    img.style.display = 'none';
    document.getElementsByClassName("discriptionG g"+img.dataset['i'])[0].style.display = 'flex'
}

function showImage(e){
    disc = e.currentTarget;
    disc.style.display = 'none'
    document.getElementsByClassName("imgG g"+disc.dataset['i'])[0].style.display = 'flex'
}

// add goods to sending params

const nameClient = document.getElementById('name');
const phoneClient = document.getElementById('number');
const adressClient = document.getElementById('adress');
const subBtn = document.querySelectorAll('.end_bar_btn');
let ite = 0;
function OrderFunction() {
    goodList.forEach(elem => {
        if (elem.amount !== 0) {
            orderDataHTML = `
            <input class="final_price" type="hidden" name="goodT[${ite}][price]" value="${elem.price}">
            <input class="final_amount" type="hidden" name="goodT[${ite}][amount]" value="${elem.amount}">
            <input class="final_good_id" type="hidden" name="goodT[${ite}][good_id]" value="${elem.dbId}">
            `;
            ite++;
            const PlaceInT = document.getElementsByClassName("container_form")[0];
            PlaceInT.insertAdjacentHTML('beforeend', orderDataHTML);
        }
    })
}


subBtn[0].addEventListener('click', orderF)
function orderF() {
    if (nameClient.validity.valid && phoneClient.validity.valid && adressClient.validity.valid) {
        OrderFunction();
        console.log('valid1');
    }
}
