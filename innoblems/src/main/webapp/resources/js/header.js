window.addEventListener("load", function(){
    header_menu()
})

function header_menu(){
    // 카운트값 이용해서 마우스 위치 파악해서 메뉴팝업 메뉴에 마우스가 올라가면 1 아니면 0
    let pop_count = 0;
    let count = 0;
    let menu_img = document.querySelector("header .menu_img")
    let menu_list = document.querySelector("header .menu")
    let display = document.querySelector("body")
	
	//카운트값으로 구분해서 block || none
    menu_img.addEventListener("click", function(){
        if(count == 0){
            menu_list.style.display = "block"
            count = 1;
        } else {
            menu_list.style.display = "none"
            count = 0;
        }
    })

    menu_img.addEventListener("mouseover", function(){
        pop_count = 1;
    })

    menu_img.addEventListener("mouseout", function(){
        pop_count = 0;
    })

    menu_list.addEventListener("mouseover", function(){
        pop_count = 1;
    })

    menu_list.addEventListener("mouseout", function(){
        pop_count = 0;
    })

    display.addEventListener("click", function(){
        if(pop_count == 0){
            menu_list.style.display = "none"
            count = 0;
        }
    })
}