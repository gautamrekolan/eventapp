$(function() {
    $('[data-validate]').blur(function() {
        $this = $(this);
        $.get($this.data('validate'), {
            user: $this.val()
        }).success(function() {
            $this.removeClass('field_with_errors');
        }).error(function() {
            $this.addClass('field_with_errors');
        });
    });

	$('[data-validate]').keypress(function() {
        $this = $(this);
        $.get($this.data('validate'), {
            user: $this.val()
        }).success(function() {
            $this.removeClass('field_with_errors');
        }).error(function() {
            $this.addClass('field_with_errors');
        });
    });

});