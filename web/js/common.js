var seeBigImg = function (imgArray, index) { //图片查看详情图
    //imgArray 图片路径数组 
    //index 点击图片的索引
    if (imgArray.length <= 0) return;
    var htmlTop = "<div class='bigImgWrap swiper-container'><ul class='swiper-wrapper'>";
    var htmlContent = "";
    var htmlBtm = "</ul><div class='swiper-pagination'></div></div>"

    for (var i = 0; i < imgArray.length; i++) {
        htmlContent += "<li class='swiper-slide'><img src=\"" + imgArray[i] + "\" /></li>";
    }
    var html = htmlTop + htmlContent + htmlBtm;
    var js = "<script class='imgJs'>var mySwiper = new Swiper('.bigImgWrap',{grabCursor: true,paginationClickable: true,speed: 1000,pagination: '.swiper-pagination',initialSlide :" + index + ", });</script>";

    $('body').append(html);
    $('html').append(js);

    var $wrap = $('.bigImgWrap');
    $wrap.css({ //容器样式
        "width": "16rem",
        "height": $(window).outerHeight(),
        "position": "fixed",
        "top": "0",
        "left": "0",
        "background-color": "rgba(0,0,0,.7)",
        "z-index": "9999"
    });

    $wrap.find('img').css({ //图片样式
        'width': '16rem',
        "height": "70%",
        "margin-top": $(window).outerHeight() * .15,
    });

    $wrap.on('click', function (e) {
        if (e.target.nodeName != 'IMG') {
            $wrap.remove();
            $('html').find("script[class='imgJs']").remove();
        }
    });

}
