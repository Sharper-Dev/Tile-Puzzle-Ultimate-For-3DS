local Script = {}

function Script.check(board)
    if #board.places ~= 9 then return false end

    for index, place in ipairs(board.places) do
        local piece = place.currentPiece
        if index == 9 then
            if piece then return false end
        elseif not piece or piece.number ~= index then
            return false
        end
    end

    return true
end

return Script