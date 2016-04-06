require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :title => "MyText",
      :user => "",
      :city => ""
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "textarea#event_title[name=?]", "event[title]"

      assert_select "input#event_user[name=?]", "event[user]"

      assert_select "input#event_city[name=?]", "event[city]"
    end
  end
end
