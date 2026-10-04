--- A math extender module for Micro2D.
--- @module extender_math
--- @author Sharper Dev

local MathE = {}

--- Linearly interpolates from a to b using the factor t.
--- Values of t outside [0, 1] extrapolate beyond the endpoints.
--- @param a number Starting value.
--- @param b number Ending value.
--- @param t number Interpolation factor.
--- @return number
--- @usage local result = MathE.lerp(0, 100, 0.5) -- result is 50
function MathE.lerp(a, b, t)
    return a + (b - a) * t
end

--- Tests whether a point lies inside or on the boundary of an axis-aligned rectangle.
--- @param rectX number Rectangle's left coordinate.
--- @param rectY number Rectangle's top coordinate.
--- @param rectW number Rectangle width.
--- @param rectH number Rectangle height.
--- @param pointX number Point's horizontal coordinate.
--- @param pointY number Point's vertical coordinate.
--- @return boolean inside True if the point is within the rectangle.
--- @usage local inside = MathE.checkAABBPoint(0, 0, 100, 100, 50, 50) -- inside is true
function MathE.checkAABBPoint(rectX, rectY, rectW, rectH, pointX, pointY)
    return pointX >= rectX and pointX <= rectX + rectW and
               pointY >= rectY and pointY <= rectY + rectH
end

--- Tests whether two axis-aligned rectangles overlap or touch at an edge.
--- @param rectX1 number First rectangle's left coordinate.
--- @param rectY1 number First rectangle's top coordinate.
--- @param rectW1 number First rectangle's width.
--- @param rectH1 number First rectangle's height.
--- @param rectX2 number Second rectangle's left coordinate.
--- @param rectY2 number Second rectangle's top coordinate.
--- @param rectW2 number Second rectangle's width.
--- @param rectH2 number Second rectangle's height.
--- @return boolean intersects True if the rectangles overlap or touch.
--- @usage local intersects = MathE.checkAABBRect(0, 0, 100, 100, 50, 50, 100, 100) -- intersects is true
function MathE.checkAABBRect(rectX1, rectY1, rectW1, rectH1, rectX2, rectY2, rectW2, rectH2)
    return rectX1 <= rectX2 + rectW2 and
               rectX1 + rectW1 >= rectX2 and
               rectY1 <= rectY2 + rectH2 and
               rectY1 + rectH1 >= rectY2
end

return MathE