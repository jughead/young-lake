module FormHelper
  def callendar_input_group_addon
    content_tag :span, class: 'input-group-addon' do
      content_tag :span, '', class: 'glyphicon glyphicon-calendar'
    end
  end

  def bootstrap_datetime_picker(form, attribute)
    object = form.object
    converted_value = object.public_send(attribute)
    converted_value = Time.zone.parse(converted_value) rescue nil if converted_value.is_a?(String)
    converted_value = converted_value ? converted_value.strftime('%d.%m.%y %H:%M:%S') : converted_value
    content_tag(:div, class: 'input-group date js-datetime-picker') do
      capture do
        concat form.text_field(attribute, value: converted_value, class: 'form-control')
        concat callendar_input_group_addon
      end
    end
  end

  def simple_form_for_filterrific(record, options={}, &block)
    # just copied from filterrific /lib/filterrific/action_view_extension.rb#L14
    options[:as] ||= :filterrific
    options[:html] ||= {}
    options[:html][:method] ||= :get
    options[:html][:id] ||= :filterrific_filter
    options[:url] ||= url_for(
      :controller => controller.controller_name,
      :action => controller.action_name
    )

    simple_form_for(record, options, &block)
  end
end
