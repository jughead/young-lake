require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :title => "MyText",
      :user => "",
      :city => ""
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "textarea#event_title[name=?]", "event[title]"

      assert_select "input#event_user[name=?]", "event[user]"

      assert_select "input#event_city[name=?]", "event[city]"
    end
  end
end
