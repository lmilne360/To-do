require 'spec_helper'

describe "Creating todo lists" do

	def create_todo_list(options={})
		options[:title] ||="My todo List"
		options[:description] ||= "This is my todo list."

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in"Description", with: options[:description]
		click_button "Create Todo list"
	end
	it "redirects to the todo list index page on success" do

		create_todo_list

		expect(page).to have_content("My todo list")


	end

	it "displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)
		create_todo_list title: ""


		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what i'm doing today")
	end

	it "displays an error when the todo list has a title less than 3 characters" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Hi"
		fill_in"Description", with: "This is what I'm doing today."
		click_button "Create Todo list"


		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what i'm doing today")
	end

	it "displays an error when the todo list has no description" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Grocery list"
		fill_in"Description", with: ""
		click_button "Create Todo list"


		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery list")
	end

it "displays an error when the todo list has less than 5 description chars" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Grocery list"
		fill_in"Description", with: "Food"
		click_button "Create Todo list"


		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery list")
	end

end