(function ($) {

    $.fn.multiSelect = function (ButtonName, options) {

        let settings;
        if ('string' === typeof options) {
            settings = options;
        } else {
            settings = $.extend({
                placeholder: 'Виберіть',
                numDisplayed: 3,
                overflowText: '{n} вибрано',
                searchText: 'Пошук',
                noResultsText: 'Нічого не знайдено',
                showSearch: true,
                optionFormatter: false,
                buttonText: ButtonName
            }, options);
        }

        /**
         * Constructor
         */
        function multiSelect(select, settings) {
            this.$select = $(select);
            this.settings = settings;
            this.create();
        }


        /**
         * Prototype class
         */
        multiSelect.prototype = {
            create: function () {
                this.settings.multiple = this.$select.is('[multiple]');
                let multiple = this.settings.multiple ? ' multiple' : '';

                this.$select.wrap('<li class="filter' + multiple + '" tabindex="0" />');

                this.$select.before('<button class="dropdownButton">' +
                    '<div class="dropdownButton__text">' + this.settings.buttonText + '</div>' +
                    '</button>');
                this.$select.before('<div class="dropdown-content hidden">' +
                    '<div class="list"></div>' +
                    '</div>');

                this.$select.addClass('hidden');
                this.$wrap = this.$select.closest('.filter');
                this.$wrap.data('id', window.multiSelect.num_items);
                window.multiSelect.num_items++;
                this.reload();
                this.resetSelected();
                this.resetSearchBox();
            },

            reload: function () {
                if (this.settings.showSearch && this.settings.buttonText !== 'Сортувати') {

                    let search =
                        '<div class="headerFilter">' +
                        '<p class="headerFilter__text"></p>' +
                        '<button class="headerFilter__button">Очистити</button>' +
                        '</div>' +
                        '<div class="search">' +
                        '<input type="text" placeholder="' + this.settings.searchText + '" />' +
                        '<i class="clearSearchButton">&times;</i>' +
                        '</div>';
                    this.$wrap.find('.dropdown-content').prepend(search);
                }
                if ('' !== this.settings.noResultsText) {
                    let no_results_text = '<div class="search-no-results hidden">' + this.settings.noResultsText + '</div>';
                    this.$wrap.find('.list').before(no_results_text);
                }
                this.idx = 0;
                this.optgroup = 0;
                this.selected = [].concat(this.$select.val()); // force an array
                let choices = this.buildOptions(this.$select);
                this.$wrap.find('.list').html(choices);
                this.reloadDropdownLabel();
            },

            destroy: function () {
                this.$wrap.find('.dropdownButton').remove();
                this.$wrap.find('.dropdown-content').remove();
                this.$select.unwrap().removeClass('hidden');
            },

            buildOptions: function ($element) {
                let $this = this;

                let choices = '';
                $element.children().each(function (i, el) {
                    let $el = $(el);

                    if ('optgroup' === $el.prop('nodeName').toLowerCase()) {
                        choices += '<div class="fs-optgroup-label" data-group="' + $this.optgroup + '">' + $el.prop('label') + '</div>';
                        choices += $this.buildOptions($el);
                        $this.optgroup++;
                    } else {
                        let val = $el.prop('value');

                        // exclude the first option in multi-select mode
                        if (0 < $this.idx || '' !== val || !$this.settings.multiple) {
                            let disabled = $el.is(':disabled') ? ' disabled' : '';
                            let selected = -1 < $.inArray(val, $this.selected) ? ' selected' : '';
                            let group = ' g' + $this.optgroup;
                            let row =
                                '<div class="list__el' + selected + disabled + group + '" data-value="' + val + '" data-index="' + $this.idx + '">' +
                                '   <div class="list__el_text">' + $el.html() + '</div>' +
                                '</div>';

                            if ('function' === typeof $this.settings.optionFormatter) {
                                row = $this.settings.optionFormatter(row);
                            }

                            choices += row;
                            $this.idx++;
                        }
                    }
                });

                return choices;
            },

            resetSelected: function () {

                let filterSelect = this.$select;

                $(".headerFilter__button").click(function (e) {

                    $.extend({}, e);
                    filterSelect.siblings(".dropdown-content")
                        .find(".list__el")
                        .removeClass("selected"),
                        filterSelect.siblings(".dropdown-content")
                            .find(".headerFilter")
                            .find(".headerFilter__text")
                            .text("0 вибрано"),
                        filterSelect.siblings(".dropdown-content")
                            .find(".list")
                            .find(".list__el_text")
                            .removeAttr('style');

                });

            },

            resetSearchBox : function () {

                $(".search").each(function () {

                    let $inp = $(this).find("input:text"),
                        $cle = $(this).find(".clearSearchButton");

                    $inp.on("input", function(){
                        $cle.toggle(!!this.value);
                    });

                    $cle.click(function(e) {

                        $.extend({}, e);

                        let $wrap = $(this).closest('.filter');

                        $inp.val("").trigger("input");
                        $wrap.find('.list__el').removeClass('hidden');
                        $wrap.find('.search-no-results').addClass('hidden');
                    });

                });

            },

            reloadDropdownLabel: function () {
                let settings = this.settings;
                let header__text = [];

                this.$wrap.find('.list__el.selected').each(function (i, el) {
                    header__text.push($(el).find('.list__el_text').text());
                });

                header__text = settings.overflowText.replace('{n}', header__text.length);

                this.$wrap.find('.dropdownButton__text').html(this.settings.buttonText);
                this.$wrap.find('.headerFilter__text').html(header__text);
                this.$wrap.toggleClass('fs-default', header__text === settings.placeholder);
                this.$select.change();
            }
        }


        /**
         * Loop through each matching element
         */
        return this.each(function () {
            let data = $(this).data('multiSelect');

            if (!data) {
                data = new multiSelect(this, settings);
                $(this).data('multiSelect', data);
            }

            if ('string' === typeof settings) {
                data[settings]();
            }
        });
    }

    /**
     * Events
     */
    window.multiSelect = {
        'num_items': 0,
        'active_id': null,
        'active_el': null,
        'last_choice': null,
        'idx': -1
    };

    $(document).on('click', '.list__el:not(.hidden, .disabled)', function (e) {
        let selected;
        let $wrap = $(this).closest('.filter');
        let do_close = false;

        // prevent selections
        if ($wrap.hasClass('fs-disabled')) {
            return;
        }

        if ($wrap.hasClass('multiple')) {
            selected = [];

            // shift + click support
            if (e.shiftKey && null != window.multiSelect.last_choice) {
                let current_choice = parseInt($(this).attr('data-index'));
                let addOrRemove = !$(this).hasClass('selected');
                let attr = $(this).find('.list__el_text').attr('style');
                let min = Math.min(window.multiSelect.last_choice, current_choice);
                let max = Math.max(window.multiSelect.last_choice, current_choice);

                for (let i = min; i <= max; i++) {
                    $wrap.find('.list__el[data-index=' + i + ']')
                        .not('.hidden, .disabled')
                        .each(function () {
                            $(this).toggleClass('selected', addOrRemove);

                            if (typeof attr !== typeof undefined && attr !== false) {
                                $(this).find('.list__el_text').removeAttr('style');
                            } else {
                                $(this).find('.list__el_text').attr('style', 'background-color: #0770cf; color: white;');
                            }
                        });
                }
            } else {
                window.multiSelect.last_choice = parseInt($(this).attr('data-index'));
                $(this).toggleClass('selected');
                let attr = $(this).find('.list__el_text').attr('style');

                if (typeof attr !== typeof undefined && attr !== false) {
                    $(this).find('.list__el_text').removeAttr('style');
                } else {
                    $(this).find('.list__el_text').attr('style', 'background-color: #0770cf; color: white;');
                }
            }

            $wrap.find('.list__el.selected').each(function (i, el) {
                selected.push($(el).attr('data-value'));
            });
        } else {
            selected = $(this).attr('data-value');
            $wrap.find('.list__el').removeClass('selected');
            $wrap.find('.list__el_text').removeAttr('style');
            $(this).addClass('selected');
            do_close = true;
        }

        $wrap.find('select').val(selected);
        $wrap.find('select').multiSelect("", 'reloadDropdownLabel');

        // fire an event
        $(document).trigger('fs:changed', $wrap);

        if (do_close) {
            closeDropdown($wrap);
        }
    });

    $(document).on('keyup', '.search input', function (e) {
        if (40 === e.which) { // down
            $(this).blur();
            return;
        }

        let $wrap = $(this).closest('.filter');
        let matchOperators = /[|\\{}()[\]^$+*?.]/g;
        let keywords = $(this).val().replace(matchOperators, '\\$&');

        $wrap.find('.list__el, .fs-optgroup-label').removeClass('hidden');

        if ('' !== keywords) {
            $wrap.find('.list__el').each(function () {
                let regex = new RegExp(keywords, 'gi');
                if (null === $(this).find('.list__el_text').text().match(regex)) {
                    $(this).addClass('hidden');
                }
            });

            $wrap.find('.fs-optgroup-label').each(function () {
                let group = $(this).attr('data-group');
                let num_visible = $(this).closest('.list').find('.list__el.g' + group + ':not(.hidden)').length;
                if (num_visible < 1) {
                    $(this).addClass('hidden');
                }
            });
        }

        setIndexes($wrap);
        checkNoResults($wrap);
    });

    $(document).on('click', function (e) {
        let $el = $(e.target);
        let $wrap = $el.closest('.filter');

        if (0 < $wrap.length) {

            // user clicked another multiSelect box
            if ($wrap.data('id') !== window.multiSelect.active_id) {
                closeDropdown();
            }

            // multiSelect box was toggled
            if ($el.hasClass('dropdownButton__text')) {
                let is_hidden = $wrap.find('.dropdown-content').hasClass('hidden');

                if (is_hidden) {
                    openDropdown($wrap);
                } else {
                    closeDropdown($wrap);
                }
            }
        } else { // clicked outside, close all multiSelect boxes
            closeDropdown();
        }
    });

    $(document).on('keydown', function (e) {
        let $next;
        let $current;
        let $wrap = window.multiSelect.active_el;
        let $target = $(e.target);

        // toggle the dropdown on space
        if ($target.hasClass('filter')) {
            if (32 === e.which || 13 === e.which) {
                e.preventDefault();
                $target.find('.dropdownButton__text').trigger('click');
                return;
            }
        }
        // preserve spaces during search
        else if (0 < $target.closest('.search').length) {
            if (32 === e.which) {
                return;
            }
        } else if (null === $wrap) {
            return;
        }

        if (38 === e.which) { // up
            e.preventDefault();

            $wrap.find('.list__el.hl').removeClass('hl');

            $current = $wrap.find('.list__el[data-index=' + window.multiSelect.idx + ']');
            let $prev = $current.prevAll('.list__el:not(.hidden, .disabled)');

            if ($prev.length > 0) {
                window.multiSelect.idx = parseInt($prev.attr('data-index'));
                $wrap.find('.list__el[data-index=' + window.multiSelect.idx + ']').addClass('hl');
                setScroll($wrap);
            } else {
                window.multiSelect.idx = -1;
                $wrap.find('.search input').focus();
            }
        } else if (40 === e.which) { // down
            e.preventDefault();

            $current = $wrap.find('.list__el[data-index=' + window.multiSelect.idx + ']');
            if ($current.length < 1) {
                $next = $wrap.find('.list__el:not(.hidden, .disabled):first');
            } else {
                $next = $current.nextAll('.list__el:not(.hidden, .disabled)');
            }

            if ($next.length > 0) {
                window.multiSelect.idx = parseInt($next.attr('data-index'));
                $wrap.find('.list__el.hl').removeClass('hl');
                $wrap.find('.fs-list__el[data-index=' + window.multiSelect.idx + ']').addClass('hl');
                setScroll($wrap);
            }
        } else if (32 === e.which || 13 === e.which) { // space, enter
            e.preventDefault();

            $wrap.find('.list__el.hl').click();
        } else if (27 === e.which) { // esc
            closeDropdown($wrap);
        }
    });

    function checkNoResults($wrap) {
        let addOrRemove = $wrap.find('.list__el:not(.hidden)').length > 0;
        $wrap.find('.search-no-results').toggleClass('hidden', addOrRemove);
    }

    function setIndexes($wrap) {
        $wrap.find('.list__el.hl').removeClass('hl');
        $wrap.find('.search input').focus();
        window.multiSelect.idx = -1;
    }

    function setScroll($wrap) {
        let to;
        let $container = $wrap.find('.list');
        let $selected = $wrap.find('.list__el.hl');

        let itemMin = $selected.offset().top + $container.scrollTop();
        let itemMax = itemMin + $selected.outerHeight();
        let containerMin = $container.offset().top + $container.scrollTop();
        let containerMax = containerMin + $container.outerHeight();

        if (itemMax > containerMax) { // scroll down
            to = $container.scrollTop() + itemMax - containerMax;
            $container.scrollTop(to);
        } else if (itemMin < containerMin) { // scroll up
            to = $container.scrollTop() - containerMin - itemMin;
            $container.scrollTop(to);
        }
    }

    function openDropdown($wrap) {
        window.multiSelect.active_el = $wrap;
        window.multiSelect.active_id = $wrap.data('id');
        window.multiSelect.initial_values = $wrap.find('select').val();
        $wrap.find('.dropdown-content').removeClass('hidden');
        $wrap.addClass('open');
        setIndexes($wrap);
        checkNoResults($wrap);
    }

    function closeDropdown($wrap) {
        if ('undefined' == typeof $wrap && null != window.multiSelect.active_el) {
            $wrap = window.multiSelect.active_el;
        }
        if ('undefined' !== typeof $wrap) {
            // only trigger if the values have changed
            let initial_values = window.multiSelect.initial_values;
            let current_values = $wrap.find('select').val();
            if (JSON.stringify(initial_values) != JSON.stringify(current_values)) {
                $(document).trigger('fs:closed', $wrap);
            }
        }

        $('.filter').removeClass('open');
        $('.dropdown-content').addClass('hidden');
        window.multiSelect.active_el = null;
        window.multiSelect.active_id = null;
        window.multiSelect.last_choice = null;
    }

})(jQuery);
