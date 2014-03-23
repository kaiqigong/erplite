! function ($) {

    var ProgressBar = function (element, options) {
        this.element = $(element);
        this.percent = 0;
        var hasOptions = typeof options == 'object';
        this.element.html($(DRPGlobal.template));
    };

    ProgressBar.prototype = {
        constructor: ProgressBar,

        set: function (percent) {
            if (typeof (percent) == 'number' && percent <= 100 && percent >= 0) {
                this.percent = percent;
                this.element.find('.progress-bar-success').css('width', this.percent + "%");
            }
        },

        reset: function () {
            this.percent = 0;
            this.element.find('.progress-bar-success').css('width', "0%");
        },

        start: function () {
            this.reset();
            this.percent = 30;
            this.element.fadeIn();
            this.element.find('.progress-bar-success').css('width', this.percent + "%");
        },

        almost: function () {
            this.percent = 90;
            this.element.fadeIn();
            this.element.find('.progress-bar-success').css('width', this.percent + "%");
        },

        finish: function () {
            this.set(100);
            this.element.fadeOut();
        }
    };

    $.fn.progressbar = function (option) {
        var args = Array.apply(null, arguments);
        args.shift();
        return this.each(function () {
            var $this = $(this),
                data = $this.data('progressbar'),
                options = typeof option == 'object' && option;

            if (!data) {
                $this.data('progressbar', new ProgressBar(this, $.extend({}, $.fn.progressbar().defaults, options)));
            }
            if (typeof option == 'string' && typeof data[option] == 'function') {
                data[option].apply(data, args);
            }
        });
    };

    $.fn.progressbar.defaults = {
        status: "success",
        showAnimation: true
    };

    $.fn.progressbar.Constructor = ProgressBar;

    var DRPGlobal = {};

    DRPGlobal.template = '<div class="progress progress-striped active">' +
        '<div class="progress-bar progress-bar-success" style="width: 0%;"></div>' +
        '</div>';

}(window.jQuery);

$(function () {
    $("#progressbar").progressbar();
    setTimeout(function () {
        $("#progressbar").progressbar("start");
    }, 100);
    setTimeout(function () {
        $("#progressbar").progressbar("almost");
    }, 500);
    setTimeout(function () {
        $("#progressbar").progressbar("finish");
    }, 1000);
});