local function is_folder_only(path)
	local p = io.popen("ls -l " .. "'" .. path .. "'", "r")
	if p == nil then
		return false
	end
	local num = -1
	local flag = false
	for line in p:lines() do
		num = num + 1
		if num == 1 and line:sub(1, 1) == "d" then
			flag = true
		end
	end
	p:close()
	return num == 1 and flag or false
end

local function get_innermost_directory(path)
	local innermost = path
	local flag = is_folder_only(innermost)
	if flag then
		local dirs = io.popen("ls " .. "'" .. path .. "'", "r")
		if dirs == nil then
			return innermost
		end
		for dir in dirs:lines() do
			innermost = innermost .. "/" .. dir
		end
		dirs:close()
		return get_innermost_directory(innermost)
	end
	return innermost
end

local function extract(archive)
	local filename = archive:match("(.*)%.([^%.]+)$")
	local _archive = "'" .. archive .. "'"
	os.execute("unar -f " .. _archive .. ">/dev/null 2>&1")
	return filename
end

local function is_archive(mime)
	local patterns = { "zip", "tar", "7z", "rar" }
	for _, pattern in ipairs(patterns) do
		if string.match(mime, pattern) then
			return true
		end
	end
	return false
end

return {
	entry = function()
		local h = cx.active.current.hovered
		if h.cha.is_dir then
			local url = tostring(h.url)
			local innermost = get_innermost_directory(url)
			ya.manager_emit("cd", { innermost })
		elseif is_archive(h:mime()) then
			local url = tostring(h.url)
			local path = extract(url)
			ya.manager_emit("cd", { path })
		else
			ya.manager_emit("open", { hovered = true })
		end
	end,
}
