export const trim_char = function(char) {
    const str = this.toString()
    let left = 0, right = str.length - 1;
    while (str[left] === char && left <= right) left ++
    while (str[right] === char && right >= left) right --

    return str.slice(left, right+1)
}
String.prototype.trim_char = trim_char;

const includes_by_key = function(key, value) {
    for(let obj of this) {
        if(obj.hasOwnProperty(key) && obj[key] === value) {
            return true;
        }
    }

    return false;
}

Array.prototype.includes_by_key = includes_by_key;