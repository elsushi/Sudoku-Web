require 'sinatra'
require_relative './lib/sudoku'
require_relative './lib/cell'

enable :sessions

def random_sudoku
	seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
	sudoku = Sudoku.new(seed.join)
	sudoku.solve!
	sudoku.to_s.chars
end

def puzzle(sudoku)
	mangled_sudoku = sudoku.dup
	(0..80).to_a.sample(rand(30)).each do |index|
		mangled_sudoku[index] = 0
	end
	mangled_sudoku
end

get '/' do
	sudoku = random_sudoku
	session[:solution] = sudoku
	@current_solution = puzzle(sudoku)
	erb :index
end

get '/solution' do
	@current_solution = session[:solution]
	erb :index
end