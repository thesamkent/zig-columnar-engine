const std = @import("std");

export fn search_column_gt(col: [*]const u64, n: usize, target: u64, out_matching_count: *usize) u64 {
    const VecLen = 8;
    const VecType = @Vector(VecLen, u64);
    const target_vec: VecType = @splat(target);

    var i: usize = 0;
    var match_count: usize = 0;
    var sum: u64 = 0;

    const vec_end = n & ~@as(usize, VecLen - 1);

    while (i < vec_end) : (i += VecLen) {
        const v: VecType = col[i..][0..VecLen].*;
        const mask = v > target_vec;

        var k: usize = 0;
        while (k < VecLen) : (k += 1) {
            if (mask[k]) {
                match_count += 1;
                sum += v[k];
            }
        }
    }

    while (i < n) : (i += 1) {
        const val = col[i];
        if (val > target) {
            match_count += 1;
            sum += val;
        }
    }

    out_matching_count.* = match_count;
    return sum;
}

export fn search_column_filter(col: [*]const u64, n: usize, target: u64, out_indices: [*]u64) usize {
    var i: usize = 0;
    var match_count: usize = 0;

    while (i < n) : (i += 1) {
        const val = col[i];
        if (val > target) {
            out_indices[match_count] = i;
            match_count += 1;
        }
    }

    return match_count;
}
