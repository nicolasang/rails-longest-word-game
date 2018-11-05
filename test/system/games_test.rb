require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "p", count: 11
  end

  test "One letter consonant word" do
    visit new_url
    fill_in "answer_input", with: "p"
    click_on "Play"
    assert_text "not an english word"
  end

  test "Word not in grid" do
    visit new_url
    fill_in "answer_input", with: "qwertyuioplkjhgfdsazxcvbnm"
    click_on "Play"
    assert_text "A given character is not in the grid."
  end

  test "Winning combination" do
    visit new_url
    fill_in "answer_input", with: "cup"
    click_on "Play"
    assert_text "Congratulations! Your score is 9. Well done!"
  end
end
