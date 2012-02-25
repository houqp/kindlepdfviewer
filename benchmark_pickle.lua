#!./kpdfview

require "pickle"
require "settings"


test_sqlite = function()
	local test_file = "test_sqlite.db"
	local i = 0

	while(i < 1000) do
		--write
		a = DocSettings:open(test_file)
		a:savesetting("last_page", 15)
		a:savesetting("gamma", 1)
		a:savesetting("rotate", 10)
		a:savesetting("zoom", 1.5)
		a:close()


		--read
		a = DocSettings:open(test_file)
		tmp = a:readsetting("last_page")
		tmp = a:readsetting("gamma")
		tmp = a:readsetting("rotate")
		tmp = a:readsetting("zoom")
		a:close()

		i = i + 1
	end
end

book_config = {
	last_page = 15,
	gamma = 1,
	rotate = 10,
	zoom = 1.5,
	jump_stack = {
		{page=1, notes="page 1"},
		{page=2, notes="page 2"},
		{page=20, notes="page 20"},
		{page=3, notes="page 3"},
		{page=30, notes="page 30"},
	}
}

test_pickle = function()
	local test_file = "test_pickle.db"
	local i = 0

	while(i < 1000) do
		--write
		--local file = io.open(test_file, "w")
		dump = pickle.dump(book_config, test_file)
		--file:write(dump)
		--file:close()

		--read
		bc = pickle.load(test_file)
		i = i + 1
	end
end

start = os.clock()
test_sqlite()
stop = os.clock()
print("Time for sqlite3 approach: "..(stop - start))


start = os.clock()
test_pickle()
stop = os.clock()
print("Time for pickle approach: "..(stop - start))
