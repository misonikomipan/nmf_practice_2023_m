% Euclid距離に基づくNMFの計算
nRow = 10;
nCol = 10;
X = rand(nRow, nCol);  % 分解したい行列X
isLin = false;  % コスト関数のプロットを線形でするか（True）対数でするか（False）

% 初期値の設定
nBasis = 4; % 基底数
W = rand(nRow, nBasis); % 基底行列
H = rand(nBasis, nCol); % 係数行列
% 初期状態のコスト計算
cost(1) = calc_cost(X, W*H);


% NMFの計算
nIter = 50; % 反復回数
for iIter = 1:nIter
    W = W .* ((X*H')./(W*H*H'));
    H = H .* ((W'*X)./(W'*W*H));
    cost(iIter+1) = calc_cost(X, W*H);
end

% 目的関数の遷移をプロット
plot_cost(cost, isLin)



function cost = calc_cost(A, B)
    % AとBのユークリッド距離を計算する関数
    % ワンライナー
    cost = sum((A-B).^2, "all");
    % 愚直版
    % cost = 0;
    % for i = 1:size(A, 1)
    %     for j = 1:size(A, 2)
    %         cost = cost + (A(i, j) - B(i, j))^2;
    %     end
    % end

end

function plot_cost(cost, isLin)
    if isLin
        % コスト関数値のグラフ描画(線形)
        figure; plot(cost);
        xlabel("反復回数", "FontSize", 14);
        ylabel("コスト関数値(線形軸)", "FontSize", 14);
    else
        % コスト関数値のグラフ描画(対数軸)
        figure; semilogy(cost);
        xlabel("反復回数", "FontSize", 14);
        ylabel("コスト関数値(対数軸)", "FontSize", 14);
    end
end