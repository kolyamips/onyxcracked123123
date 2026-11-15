return
  (
  function(...)
    local T, s, r, E, C, D, g, u, q, w, b, U, O, f = string.byte, string.sub, string.char, string.gsub, string.rep, setmetatable, pcall, type, tostring, assert, loadstring, unpack, string.pack, {}
    local m = {}
    local l = bit32
    local K, e, h, Z, o = _ENV, getfenv, metatable, unpack, "!!!"
    local I, t, a = "-", true, nil
    local H, S = nil, 0
    local L =
      {
        M5ShoQ6=
        "v!!!",
      }
    local T =
      {
        "GetService",
        "workspace",
        "Quantum Onyx",
        "Credits",
        "Value",
        "global",
        "addDropdown",
        "random",
        "You Are Lost!",
        "__gc",
        "min",
        "HryEtiBj9ksd3S",
        "Enable Resize Weapon",
        "damage",
        "QuantumOnyx",
        "Name",
        "GetChildren",
        "YrK2PeGH9L",
        "CreateWindow",
        "error",
        "rawset",
        "FindFirstChildWhichIsA",
        "ProximityPrompt",
        "Tool",
        "gsub",
        "typeof",
        "Parent",
        "step",
        "already executed",
        "TreesFolder",
        "Tester",
        "Auto Collect Chest",
        "Time",
        "TEYbRf3DHqoe",
        "fireproximityprompt",
        "Signal",
        "callback",
        "qTEasdwii8tN",
        "CFrame",
        "Title",
        "CreateToggle",
        "BHcF1cLGlOyU",
        "l1",
        "RunService",
        "type",
        "CreateDropdown",
        "eWd1zIuCJ51uH3",
        "7CMjGwyP0eH5Z",
        "Y33aw6vg2WtR",
        "home-quantum",
        "iuwJ1iwCouC0xM",
        "Description",
        ":",
        "math",
        "game",
        "qjUEniGVqQTp",
        "YgNM8kwDhVgj1",
        "insert",
        "hHsGHL8QV4uy5",
        "ClassName",
        "Web Designer",
        "setmetatable",
        "spawn",
        "addSection",
        "Model",
        "Cut Trees",
        "wait",
        "addSlider",
        ":(%d*):",
        "Vin",
        "__index",
        "q2qu7QgD08eZ4i",
        "PrimaryPart",
        "si9T1NdNjRvyl",
        "WaitForChild",
        "Util/Library.lua",
        "GamepassFolder",
        "ykqOn0CYhd5mY",
        "string",
        "concat",
        "SendNotify",
        "Character",
        "EnableResizeWeapon",
        "Kiel",
        "04s397cRDxrzM",
        "addToggle",
        "Players",
        "Auto Chop Trees",
        "Theme",
        "AutoCollectChest",
        "Tree",
        "BoolValue",
        "ChestFolder",
        "addMenu",
        "EdOiGDuPTwhv",
        "IIOQQyfKWVnWZ",
        "pairs",
        "Notify",
        "next",
        "description",
        "Key",
        "IsA",
        "WeaponSize",
        "Purple",
        "getmetatable",
        "HIIGYp3YUR81Y",
        "9ltmeZ4xsMvm3G",
        "ValueBase",
        "Weapon Size",
        "Unlock All Gamepasses",
        "zTkRpxHwtwuqS",
        "Subtitle",
        "Handle",
        "LocalPlayer",
        "ReplicatedStorage",
        "Size",
        "pcall",
        "jPtSGN2abnNxGy",
        "GetDescendants",
        "tostring",
        "HttpGet",
        "task",
        "Main Farm",
        "AddTab",
        "Developers",
        "Version",
        "Hxlp9BG7EcwE1M",
        "loadstring",
        "gJRjkjv7iX6eMg",
        "Vector3",
        "CudalPH",
        "BasePart",
        "tonumber",
        "locked",
        "stop skidding - flazhy",
        "Gamepass Bypass",
        "Success Unlocked",
        "vUCuJxlhRC6d",
        "Flazhy and Huyz",
        "Notification",
        "Server Owner",
        "DataModel",
        "Home",
        "rawget",
        "LyOlTGYV",
        "Role",
        "Instance",
        "VElfRyu6p7oQLZ",
        "23LFGB6M4KON",
        "CwCdPZg88kpoCE",
        "unpack",
        "__len",
        "getgenv",
        "FireServer",
        "FindFirstChild",
        "mdrBEFOQbNz1",
        "mXeiSKbb1DOh",
        "function",
        "v.Premium",
        "AutoChopTrees",
        "Full",
        "neZ7AJtpuz0yT",
        "gmatch",
        "CreateSlider",
        "Failed Unlock",
        "table",
        "https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/",
        "new",
        "PaXnnHfTYXoq",
        "CharacterAdded",
        "Wait",
        "Jl4cvQGXQkiQk",
        "F7LY6RSCz4qpY",
        "warn",
        "kLdN5LLo4q",
        "addButton",
        "l2",
        "HumanoidRootPart",
        "ipairs",
      }
    local function s(s)
      return
        T[s+26184]
    end
    for s,r in ipairs({{1;179};{1;76},{77;179}})do while r[1]<r[2]do T[r[1]],T[r[2]],r[1],r[2]=T[r[2]],T[r[1]],r[1]+1,r[2]-1 end end
    do
      local s = T
      local r = {}
      local function E(T)
        local s = {}
        local r = 1
        local E = #T
        while r<=E do
          local C = string.sub(T,r,r)
          if C=="z"then
            table.insert(s,string.char(0,0,0,0))
            r = r+1
          elseif C:match("%s")then
            r = r+1
          else
            local C = {}
            local D = 0
            while D<5 and r+D<=E do
              local s = string.sub(T,r+D,r+D)
              if s=="z"or s==" "or s=="\n"or s=="\r"then
                break
              end
              C[#C+1] = s
              D = D+1
            end
            local g = #C
            for T=g+1,5,1 do C[#C+1]="u"end
            local u = 0
            for T=1,5,1 do u=u*85+(string.byte(C[T])-33)end
            local q = g-1
            for T=3,3-(q-1),-1 do local r=math.floor(u/256^T)%256 table.insert(s,string.char(r))end
            r = r+g
          end
        end
        return
          table.concat(s)
      end
      for T=1,#s,1 do local r=s[T]if type(r)=="string"then s[T]=E(r)end end
    end
    return
      (
      function(T,E,C,D,g,u,q,h,e,H,I,a,K,O,o,r,m,f,Z,t,w,S,U,l,b)
        f, l, K, S, r, I, H, m, b, U, a, h, Z, O, w, t, o, e =
          function(T)
            for s=1,#T,1 do b[T[s]]=1+b[T[s]]end
            if C then
              local r = C(true)
              local E = g(r)
              E["Instance"], E["addToggle"], E["Y33aw6vg2WtR"] =
                T,
                m,
                function()
                  return
                    2331648
                end
              return
                r
            else
              return
                D({},{["addToggle"]=m,["Instance"]=T;["Y33aw6vg2WtR"]=function()return 2331648 end})
            end
          end,
          function(T)
            b[T] = b[T]-1
            if 0==b[T]then
              b[T], w[T] = nil, nil
            end
          end,
          function(T,s)
            local E = f(s)
            local C =
              function(...)
                return
                  r(T,{...},s,E)
              end
            return
              C
          end,
          function(T,s)
            local E = f(s)
            local C =
              function(C,D,g,u,q,w,b,U,O,f)
                return
                  r(T,{C;D;g;u,q;w,b,U,O,f},s,E)
              end
            return
              C
          end,
          function(r,C,D,g)
            local Dt, v, z, b, n, k, N, G, X, A, L, j, st, M, W, y, R, Ct, J, Y, K, Et, O, i, F, q, Tt, d, B, p, c, f, rt, m, V, Q, x, P
            while r do
              if r<9305913 then
                if r<4371927 then
                  if r<2423249 then
                    if r<838590 then
                      if r<614119 then
                        if r<324806 then
                          if r<229189 then
                            if r<170675 then
                              M = "CudalPH"
                              Q = T[M]
                              M = "Gamepass Bypass"
                              K = r
                              L = Q[M]
                              Q = "CFrame"
                              p = L~=Q
                              m = p
                              r = p and 375808 or 14830592
                            else
                              K = "Handle"
                              O = "HttpGet"
                              q = T[O]
                              m = w[D[1]]
                              f = m[K]
                              O = q(f)
                              q = "game"
                              r = O==q
                              r = r and 9546752 or 15694336
                            end
                          else
                            if r<303033 then
                              b = nil
                              q = {}
                              r = T["Wait"]
                            else
                              Q = "WeaponSize"
                              r = 16769024
                              L = K[Q]
                              q = L
                            end
                          end
                        else
                          if r<448148 then
                            if r<347263 then
                              r = 3326464
                              b = nil
                            else
                              r = K
                              r = 5471744
                              O = m
                            end
                          else
                            r = 12901888
                            n = nil
                            c = l(c)
                            W = l(W)
                            A = l(A)
                            N = l(N)
                            j = l(j)
                            v = l(v)
                          end
                        end
                      else
                        if r<781906 then
                          if r<735127 then
                            if r<700158 then
                              q = "Enable Resize Weapon"
                              r = m[q]
                              w[D[2]] = r
                              r = 14030336
                            else
                              r = 7796224
                            end
                          else
                            W = 100
                            v = U()
                            w[v] = F
                            j = "Vector3"
                            q = T[j]
                            j = "Kiel"
                            r = q[j]
                            j = 1
                            q = r(j,W)
                            j = U()
                            P = 10000
                            W = 0
                            w[j] = q
                            r = w[L]
                            A = 255
                            q = r(W,A)
                            W = U()
                            w[W] = q
                            r = w[L]
                            N = w[j]
                            A = 1
                            n = 2
                            q = r(A,N)
                            A = U()
                            w[A] = q
                            q = w[L]
                            c = 1
                            N = q(c,n)
                            n = "gJRjkjv7iX6eMg"
                            q = 1
                            X = 0
                            d = "GetChildren"
                            r = N==q
                            N = U()
                            q = "LyOlTGYV"
                            w[N] = r
                            G = T[d]
                            J = w[L]
                            r = "Key"
                            Tt =
                              {
                                J(X,P),
                              }
                            r = x[r]
                            d = G(E(Tt))
                            G = "gJRjkjv7iX6eMg"
                            st = d..G
                            c = n..st
                            n = "damage"
                            r = r(x,q,c)
                            c = U()
                            w[c] = r
                            q = T[n]
                            st = I(16645120,{L,v;V;f,O;Y;N,c;j;A;W,M})
                            n =
                              {
                                q(st),
                              }
                            r =
                              {
                                E(n),
                              }
                            n = r
                            r = w[N]
                            r = r and 14436352 or 3788288
                          end
                        else
                          if r<815922 then
                            if r<792795 then
                              K = nil
                              r = 11637248
                              p = l(p)
                            else
                              d = 1
                              G = n[d]
                              r = 15427072
                              st = G
                            end
                          else
                            B = "Tester"
                            M = a(10334208,{Q;D[1],m})
                            k = w[Q]
                            V = k[B]
                            y = "Purple"
                            B = w[Q]
                            k = B[y]
                            B = w[m]
                            y = "rawget"
                            y = O[y]
                            r =
                              {
                                y(O,f,K,p,L,M,V,k,B),
                              }
                            q =
                              {
                                E(r),
                              }
                            r = T["Tool"]
                          end
                        end
                      end
                    else
                      if r<1897200 then
                        if r<1260754 then
                          if r<1036363 then
                            if r<984120 then
                              r = T["VElfRyu6p7oQLZ"]
                              q = {}
                            else
                              r = "HumanoidRootPart"
                              b = C[1]
                              r = b[r]
                              q = "Server Owner"
                              r = r(b,q)
                              r = r and 15655424 or 3146240
                            end
                          else
                            if r<1193953 then
                              r = w[D[1]]
                              b = "https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/"
                              q = "unpack"
                              q = r[q]
                              O = 5
                              q = q(r,b,O)
                              b = q
                              r = b and 14987264 or 337920
                            else
                              x = r
                              i = "HttpGet"
                              Y = T[i]
                              r = Y and 4370944 or 2379264
                              y = Y
                            end
                          end
                        else
                          if r<1818488 then
                            if r<1721478 then
                              m = "function"
                              b = C[1]
                              f = w[D[1]]
                              O = f[m]
                              q = O
                              r = O and 7145984 or 9572864
                            else
                              r = w[D[1]]
                              r = r and 7188480 or 10365952
                            end
                          else
                            q = {}
                            r = T["hHsGHL8QV4uy5"]
                          end
                        end
                      else
                        if r<2375069 then
                          if r<2270479 then
                            if r<2016180 then
                              b = q
                              q = "description"
                              r = "Notify"
                              r = b[r]
                              r = r(b,q)
                              O = r
                              r = O and 8367616 or 3228672
                            else
                              q = {}
                              r = T["Vin"]
                            end
                          else
                            f = "__index"
                            O = T[f]
                            m = "getmetatable"
                            r = T["Hxlp9BG7EcwE1M"]
                            f =
                              {
                                O(m),
                              }
                            q =
                              {
                                E(f),
                              }
                          end
                        else
                          if r<2398316 then
                            if r<2395683 then
                              r = x
                              r = 15100416
                              k = y
                            else
                              z = w[O]
                              F = z
                              r = z and 9854976 or 6788608
                            end
                          else
                            q = "F7LY6RSCz4qpY"
                            r = {}
                            f = r
                            Q = "ChestFolder"
                            r = T[q]
                            p = w[D[2]]
                            Q = p[Q]
                            L =
                              {
                                Q(p),
                              }
                            p =
                              {
                                r(E(L)),
                              }
                            K = p[3]
                            m = p[2]
                            q = p[1]
                            p = q
                            r = 12103680
                          end
                        end
                      end
                    end
                  else
                    if r<3393906 then
                      if r<3127477 then
                        if r<2801268 then
                          if r<2492874 then
                            if r<2481868 then
                              b = "IIOQQyfKWVnWZ"
                              f = 0
                              r = T[b]
                              O = w[D[8]]
                              b = r(O,f)
                              r = 7571968
                            else
                              r = w[D[2]]
                              q = w[D[3]]
                              O = b
                              r[q] = O
                              r = 189952
                            end
                          else
                            if r<2533496 then
                              m = nil
                              r = 5092352
                            else
                              r = "Description"
                              r = f[r]
                              q = "__gc"
                              r = r(f,q)
                              m = r
                              r = m and 15040000 or 2504704
                            end
                          end
                        else
                          if r<3123784 then
                            if r<2900945 then
                              A = "pairs"
                              W = T[A]
                              v = W
                              r = 8492032
                            else
                              r = w[D[1]]
                              r = r and 1162752 or 3326464
                            end
                          else
                            Q = a(14379520,{p})
                            L = "damage"
                            r = T[L]
                            L = r(Q)
                            r = 786432
                          end
                        end
                      else
                        if r<3244468 then
                          if r<3209898 then
                            if r<3185219 then
                              q = "already executed"
                              r = "HumanoidRootPart"
                              r = b[r]
                              r = r(b,q)
                              r = r and 3190784 or 9361408
                            else
                              q = "ReplicatedStorage"
                              r = b[q]
                              q =
                                {
                                  r,
                                }
                              r = T["fireproximityprompt"]
                            end
                          else
                            O = nil
                            r = T["QuantumOnyx"]
                            q = {}
                            b = nil
                          end
                        else
                          if r<3310215 then
                            if r<3281787 then
                              r = I(11353600,{m})
                              z =
                                {
                                  r(),
                                }
                              r = T["typeof"]
                              q =
                                {
                                  E(z),
                                }
                            else
                              b = "CreateWindow"
                              q = T[b]
                              b = "Home"
                              r = q[b]
                              q = r()
                              r = q and 16272384 or 2138624
                            end
                          else
                            r = T["Jl4cvQGXQkiQk"]
                            q = {}
                          end
                        end
                      end
                    else
                      if r<3728216 then
                        if r<3608778 then
                          if r<3442824 then
                            if r<3411083 then
                              K = 1
                              Q = "Vector3"
                              m = {}
                              L = T[Q]
                              Q = "Players"
                              p = L[Q]
                              Q = #f
                              L = p(O,Q)
                              p = L
                              L = 1
                              Q = L
                              L = 0
                              M = Q<L
                              r = 5811712
                              L = K-Q
                            else
                              V = "Character"
                              w[L] = q
                              M = w[L]
                              r = M[V]
                              r = r and 6105600 or 5729792
                            end
                          else
                            if r<3509439 then
                              r = 4558848
                              O = nil
                            else
                              r = 8863232
                              f = nil
                            end
                          end
                        else
                          if r<3706441 then
                            if r<3619295 then
                              r = 3228672
                              f = nil
                            else
                              L = a(6897152,{p,D[1];m})
                              M = w[p]
                              V = "Tester"
                              k = "addButton"
                              Q = M[V]
                              V = w[p]
                              M = V[k]
                              V = w[m]
                              k = "neZ7AJtpuz0yT"
                              k = O[k]
                              r =
                                {
                                  k(O,f,K,L,Q,M,V),
                                }
                              q =
                                {
                                  E(r),
                                }
                              r = T["Quantum Onyx"]
                            end
                          else
                            V = L
                            r = w[D[1]]
                            M = w[m]
                            r[M] = V
                            r = 832000
                          end
                        end
                      else
                        if r<4139509 then
                          if r<3788773 then
                            if r<3761839 then
                              r = p and 5609984 or 6854656
                            else
                              G = w[O]
                              r = G and 795648 or 15427072
                              st = G
                            end
                          else
                            O = "Time"
                            m = 5
                            f = "TEYbRf3DHqoe"
                            b = "mXeiSKbb1DOh"
                            r = T[b]
                            b = r(O,f,m)
                            r = 12365824
                          end
                        else
                          if r<4370222 then
                            if r<4163755 then
                              O = w[D[1]]
                              f = "function"
                              b = O[f]
                              q = b
                              r = b and 1997312 or 16686592
                            else
                              r = T["tonumber"]
                              q = {}
                              b = nil
                            end
                          else
                            i = r
                            j = "damage"
                            v = T[j]
                            Y = v
                            r = v and 11533312 or 12567552
                          end
                        end
                      end
                    end
                  end
                else
                  if r<6462694 then
                    if r<5707705 then
                      if r<5139052 then
                        if r<4884150 then
                          if r<4667174 then
                            if r<4552435 then
                              K = nil
                              m = nil
                              r = 4975616
                            else
                              r = 9361408
                            end
                          else
                            if r<4672212 then
                              m = w[D[1]]
                              K = "YgNM8kwDhVgj1"
                              f = m[K]
                              q = f
                              r = f and 11108864 or 15238144
                            else
                              r = 3266560
                            end
                          end
                        else
                          if r<5095697 then
                            if r<5034954 then
                              O, K = f(b,O)
                              r = O and 14349824 or 12452352
                            else
                              O = nil
                              q = {}
                              b = nil
                              r = T["Cut Trees"]
                              f = nil
                            end
                          else
                            b = C[1]
                            O = "Character"
                            q = w[D[1]]
                            r = q[O]
                            r = r and 2488320 or 189952
                          end
                        end
                      else
                        if r<5320960 then
                          if r<5205225 then
                            if r<5161775 then
                              B = r
                              x = "vUCuJxlhRC6d"
                              y = T[x]
                              r = y and 1249792 or 15100416
                              k = y
                            else
                              p = q
                              L = "Vector3"
                              q = T[L]
                              L = "Kiel"
                              r = q[L]
                              L = U()
                              Q = "spawn"
                              w[L] = r
                              q = T[Q]
                              Q = "mdrBEFOQbNz1"
                              r = q[Q]
                              V = r
                              B = "spawn"
                              k = T[B]
                              M = k
                              Q = r
                              r = k and 16693248 or 16271872
                            end
                          else
                            r = 15881216
                            L = {}
                            q = L
                          end
                        else
                          if r<5472795 then
                            if r<5456101 then
                              r = 15991808
                              p = "Util/Library.lua"
                              K = T[p]
                              M =
                                {
                                  K(m),
                                }
                              L = M[2]
                              Q = M[3]
                              p = M[1]
                            else
                              r = f
                              r = O and 10706432 or 16726016
                            end
                          else
                            r = "SendNotify"
                            p = true
                            K[r] = p
                            r = 6854656
                          end
                        end
                      end
                    else
                      if r<6090061 then
                        if r<5825645 then
                          if r<5780760 then
                            if r<5733963 then
                              k = "Tester"
                              B = "EnableResizeWeapon"
                              V = p[k]
                              M = o(5109248,{L,D[1];m})
                              B = O[B]
                              k = w[m]
                              r =
                                {
                                  B(O,f,K,p,M,V,Q,k),
                                }
                              q =
                                {
                                  E(r),
                                }
                              r = T["CwCdPZg88kpoCE"]
                            else
                              V = 3
                              y = "damage"
                              x = Z(13711872,{})
                              M = U()
                              w[M] = q
                              R = "GetChildren"
                              r = w[L]
                              k = 65
                              q = r(V,k)
                              V = U()
                              r = 0
                              w[V] = q
                              q = T[y]
                              k = r
                              y =
                                {
                                  q(x),
                                }
                              r = 0
                              q = 2
                              B = r
                              r =
                                {
                                  E(y),
                                }
                              y = r
                              r = y[q]
                              q = "TreesFolder"
                              x = r
                              r = T[q]
                              Y = w[f]
                              z = T[R]
                              R = z(x)
                              z = "LyOlTGYV"
                              F = Y(R,z)
                              Y =
                                {
                                  F(),
                                }
                              q = r(E(Y))
                              Y = U()
                              w[Y] = q
                              q = 1
                              F = w[V]
                              z = F
                              F = 1
                              R = F
                              F = 0
                              i = R<F
                              F = q-R
                              r = 12901888
                            end
                          else
                            if r<5812544 then
                              L = L+Q
                              V = not M
                              K = L<=p
                              K = V and K
                              V = L>=p
                              V = M and V
                              K = V or K
                              V = 15576576
                              r = K and V
                              K = 5451776
                              r = r or K
                            else
                              Q = w[D[4]]
                              r = 12452352
                              M = "function"
                              L = Q[M]
                              Q = "WaitForChild"
                              B = 5
                              q = L[Q]
                              k = "Parent"
                              V = T[k]
                              k = "Model"
                              M = V[k]
                              L = "ReplicatedStorage"
                              k = 0
                              y = 0
                              V = M(k,B,y)
                              Q = p+V
                              q[L] = Q
                              Q = "CreateWindow"
                              L = T[Q]
                              Q = "Home"
                              m = nil
                              q = L[Q]
                              p = nil
                              L = q()
                              q = w[D[5]]
                              L = q(K)
                              K = nil
                            end
                          end
                        else
                          if r<6048060 then
                            if r<5961580 then
                              O = b
                              r = w[D[2]]
                              q = w[D[3]]
                              r[q] = O
                              r = 15513088
                            else
                              K = f
                              L = "HumanoidRootPart"
                              Q = "next"
                              r = U()
                              w[r] = p
                              p = r
                              r = w[p]
                              L = r[L]
                              L = L(r,Q)
                              r = L and 3124224 or 786432
                            end
                          else
                            M = {}
                            r = 15750144
                            q = M
                          end
                        end
                      else
                        if r<6346294 then
                          if r<6249627 then
                            if r<6118185 then
                              r = w[D[1]]
                              M = w[m]
                              V = K
                              r[M] = V
                              r = 5729792
                            else
                              i = "si9T1NdNjRvyl"
                              r = T[i]
                              i = "GetDescendants"
                              T[i] = r
                              r = 732672
                            end
                          else
                            b = nil
                            O = nil
                            r = T["Credits"]
                            q = {}
                          end
                        else
                          if r<6387050 then
                            if r<6349713 then
                              V = U()
                              K = Q
                              B = "CreateWindow"
                              r = 15991808
                              w[V] = M
                              k = T[B]
                              M = V
                              B = "Flazhy and Huyz"
                              K = nil
                              V = k[B]
                              B = Z(6613504,{D[3],M})
                              k = V(B)
                              M = l(M)
                            else
                              r = 5735424
                              V = "7CMjGwyP0eH5Z"
                              M = T[V]
                              q = M
                            end
                          else
                            L = "CreateWindow"
                            p = T[L]
                            r = 3548160
                            L = "Home"
                            K = p[L]
                            L = 1
                            p = K(L)
                            m = nil
                          end
                        end
                      end
                    end
                  else
                    if r<7771774 then
                      if r<7136176 then
                        if r<6860356 then
                          if r<6630124 then
                            if r<6584006 then
                              O = "Handle"
                              q = w[D[1]]
                              r = q[O]
                              q = r(b)
                              r = 14713856
                            else
                              q = "damage"
                              b = o(2983936,{D[1];D[2]})
                              r = T[q]
                              q = r(b)
                              q = {}
                              r = T["CreateDropdown"]
                            end
                          else
                            if r<6843486 then
                              w[O] = F
                              r = w[O]
                              r = r and 10865664 or 4706304
                            else
                              r = 14425088
                              K = nil
                              m = nil
                            end
                          end
                        else
                          if r<7119544 then
                            if r<7037219 then
                              q = w[D[1]]
                              b = C[1]
                              O = "Character"
                              r = q[O]
                              r = r and 13231616 or 12877824
                            else
                              m = #f
                              K = 0
                              r = m==K
                              r = r and 13524480 or 3409920
                            end
                          else
                            B = "IsA"
                            Y = "CudalPH"
                            k = T[B]
                            r = 8466432
                            x = T[Y]
                            Y = "gmatch"
                            y = x[Y]
                            B = k(y)
                            k = "RunService"
                            V = B~=k
                            Q = V
                          end
                        end
                      else
                        if r<7220128 then
                          if r<7187509 then
                            if r<7175170 then
                              O = q
                              q = "description"
                              r = "Notify"
                              r = O[r]
                              r = r(O,q)
                              f = r
                              r = f and 2711552 or 5092352
                            else
                              q = w[D[3]]
                              p = q(K)
                              r = p and 5812736 or 13504512
                            end
                          else
                            K = "ChestFolder"
                            q = "F7LY6RSCz4qpY"
                            r = T[q]
                            f = w[D[1]]
                            K = f[K]
                            m =
                              {
                                K(f),
                              }
                            f =
                              {
                                r(E(m)),
                              }
                            r = 14425088
                            b = f[2]
                            O = f[3]
                            q = f[1]
                            f = q
                          end
                        else
                          if r<7709056 then
                            if r<7534203 then
                              p = "ipairs"
                              r = w[D[1]]
                              f = r
                              K = w[D[2]]
                              m = K[p]
                              K = 1
                              O = m or K
                              q = r(O)
                              r = 9288192
                            else
                              r = {}
                              b = r
                              f = w[D[9]]
                              m = f
                              f = 1
                              O = 1
                              r = 8774656
                              K = f
                              f = 0
                              p = K<f
                              f = O-K
                            end
                          else
                            f = 14640129
                            q = 9134593
                            O = "addMenu"
                            b = O^f
                            r = q-b
                            q = "jPtSGN2abnNxGy"
                            b = r
                            r = q/b
                            q =
                              {
                                r,
                              }
                            r = T["Developers"]
                          end
                        end
                      end
                    else
                      if r<8854512 then
                        if r<8467871 then
                          if r<8247449 then
                            if r<7829274 then
                              r = true
                              r = r and 9062912 or 1857024
                            else
                              r = 7796224
                            end
                          else
                            if r<8437763 then
                              r = "Description"
                              q = "__gc"
                              r = O[r]
                              r = r(O,q)
                              f = r
                              q = f
                              r = f and 15105024 or 8965120
                            else
                              p = Q
                              r = M
                              r = Q and 9080832 or 11492352
                            end
                          end
                        else
                          if r<8594498 then
                            if r<8491229 then
                              r = true
                              r = r and 13666816 or 984064
                            else
                              Y = v
                              r = j
                              r = 12567552
                            end
                          else
                            L = not p
                            f = f+K
                            O = f<=m
                            O = L and O
                            L = f>=m
                            L = p and L
                            O = L or O
                            L = 15649280
                            r = O and L
                            O = 13586432
                            r = r or O
                          end
                        end
                      else
                        if r<9078821 then
                          if r<9028813 then
                            if r<8873301 then
                              r = 10077696
                            else
                              r = q and 10511360 or 3610112
                            end
                          else
                            R = 1
                            i = 6
                            r = w[L]
                            z = r(R,i)
                            r = "si9T1NdNjRvyl"
                            T[r] = z
                            i = "si9T1NdNjRvyl"
                            R = T[i]
                            i = 2
                            r = R>i
                            r = r and 12257792 or 6231552
                          end
                        else
                          if r<9254215 then
                            if r<9211452 then
                              m = p
                              r = L
                              r = 375808
                            else
                              M = {}
                              q = M
                              r = 3416576
                            end
                          else
                            r = T["Full"]
                            b = nil
                            q = {}
                          end
                        end
                      end
                    end
                  end
                end
              else
                if r<13844361 then
                  if r<11515673 then
                    if r<10505725 then
                      if r<10058718 then
                        if r<9859599 then
                          if r<9550032 then
                            if r<9423678 then
                              r = nil
                              q =
                                {
                                  r,
                                }
                              r = T[":"]
                            else
                              O = "Handle"
                              q = w[D[1]]
                              r = q[O]
                              q = r(b)
                              r = 15694336
                            end
                          else
                            if r<9742435 then
                              f = w[D[1]]
                              m = "wait"
                              r = 7145984
                              O = f[m]
                              f = "addSlider"
                              f = O[f]
                              f = f(O)
                              q = f
                            else
                              z = k==B
                              F = z
                              r = 6788608
                            end
                          end
                        else
                          if r<10003149 then
                            if r<9978712 then
                              p = C[6]
                              b = C[1]
                              O = C[2]
                              L = C[7]
                              Q = U()
                              f = C[3]
                              m = U()
                              K = C[5]
                              w[m] = C[4]
                              w[Q] = C[8]
                              M = w[Q]
                              q = M
                              r = M and 15750144 or 6079488
                            else
                              q = "already executed"
                              r = "Notify"
                              r = b[r]
                              r = r(b,q)
                              O = r
                              r = O and 16371712 or 3471872
                            end
                          else
                            f = C[3]
                            m = U()
                            p = U()
                            b = C[1]
                            O = C[2]
                            w[m] = C[4]
                            w[p] = C[6]
                            K = C[5]
                            L = w[p]
                            q = L
                            r = L and 15881216 or 5259776
                          end
                        end
                      else
                        if r<10304493 then
                          if r<10228200 then
                            if r<10132939 then
                              f = "CreateWindow"
                              q = T[f]
                              f = "Home"
                              r = q[f]
                              q = r()
                              r = q and 4671488 or 6346240
                            else
                              L = r
                              V = "CudalPH"
                              M = T[V]
                              V = "GamepassFolder"
                              Q = M[V]
                              p = Q
                              r = Q and 13672448 or 10852352
                            end
                          else
                            Tt = 1
                            J = n[Tt]
                            G = r
                            Tt = false
                            d = J==Tt
                            r = d and 13855232 or 10659840
                            st = d
                          end
                        else
                          if r<10417800 then
                            if r<10336831 then
                              q = w[D[1]]
                              O = "Character"
                              b = C[1]
                              r = q[O]
                              r = r and 5938176 or 15513088
                            else
                              O = "Time"
                              b = "mXeiSKbb1DOh"
                              m = 5
                              f = "setmetatable"
                              r = T[b]
                              b = r(O,f,m)
                              r = 12365824
                            end
                          else
                            O = "Handle"
                            q = w[D[1]]
                            r = q[O]
                            q = r(b)
                            r = 289280
                          end
                        end
                      end
                    else
                      if r<10902598 then
                        if r<10713442 then
                          if r<10659635 then
                            if r<10620266 then
                              r = "Enable Resize Weapon"
                              q = w[D[2]]
                              f[r] = q
                              r = nil
                              w[D[2]] = r
                              r = 3610112
                            else
                              r = true
                              q = {}
                              w[D[1]] = r
                              r = T[":(%d*):"]
                            end
                          else
                            if r<10701718 then
                              r = G
                              q = st
                              r = 16302592
                            else
                              r = 16292864
                            end
                          end
                        else
                          if r<10866614 then
                            if r<10864153 then
                              r = L
                              m = p
                              r = 12722176
                            else
                              r = 16281088
                            end
                          else
                            M = "getgenv"
                            f = "home-quantum"
                            O = T[f]
                            f = O()
                            m = true
                            Dt = "9ltmeZ4xsMvm3G"
                            O = "Tree"
                            f[O] = m
                            x = "__len"
                            f = "CudalPH"
                            O = T[f]
                            m = "HryEtiBj9ksd3S"
                            L = "PaXnnHfTYXoq"
                            q = {}
                            Q = "HIIGYp3YUR81Y"
                            f = "GamepassFolder"
                            f = O[f]
                            Et = "FindFirstChildWhichIsA"
                            f = f(O,m)
                            Y = "You Are Lost!"
                            Tt = "BoolValue"
                            p = "CudalPH"
                            K = T[p]
                            p = "gmatch"
                            m = K[p]
                            K = "min"
                            O = m[K]
                            m = U()
                            K = "Subtitle"
                            w[m] = O
                            O = "unpack"
                            p = "ykqOn0CYhd5mY"
                            O = f[O]
                            O = O(f,K)
                            K = U()
                            w[K] = O
                            O = T[p]
                            p = "Description"
                            j = "qjUEniGVqQTp"
                            p = O[p]
                            P = "l1"
                            p = p(O,L)
                            O = U()
                            L = "ykqOn0CYhd5mY"
                            N = true
                            w[O] = p
                            p = T[L]
                            L = "Description"
                            L = p[L]
                            L = L(p,Q)
                            Q = "Description"
                            c = "insert"
                            p = U()
                            w[p] = L
                            L = w[m]
                            i = "DataModel"
                            Q = L[Q]
                            B = "CudalPH"
                            Q = Q(L,M)
                            L = U()
                            X = "Role"
                            rt = "qTEasdwii8tN"
                            v = "ProximityPrompt"
                            w[L] = Q
                            Q = "addSection"
                            V = "gsub"
                            M = T[V]
                            k = T[B]
                            y = Q..x
                            x = "YrK2PeGH9L"
                            x = k[x]
                            B =
                              {
                                x(k,y),
                              }
                            V = M(E(B))
                            M = V()
                            J =
                              {
                                [Tt]=
                                X,
                                [P]=
                                rt,
                              }
                            x = "string"
                            Ct = "Success Unlocked"
                            V = U()
                            X = "BoolValue"
                            P = "Signal"
                            w[V] = M
                            n = "concat"
                            A =
                              {
                                N,
                                c,
                              }
                            y = "Size"
                            M = w[V]
                            c = "GetService"
                            W = "l2"
                            rt = "l1"
                            Tt =
                              {
                                [X]=
                                P,
                                [rt]=
                                Et,
                              }
                            rt = "AutoChopTrees"
                            P = "BoolValue"
                            N = "Failed Unlock"
                            Et = "l1"
                            X =
                              {
                                [P]=
                                rt,
                                [Et]=
                                Ct,
                              }
                            Ct = "l1"
                            k = "EdOiGDuPTwhv"
                            rt = "BoolValue"
                            Et = "step"
                            P =
                              {
                                [rt]=
                                Et,
                                [Ct]=
                                Dt,
                              }
                            d =
                              {
                                J,
                                Tt,
                                X,
                                P,
                              }
                            B =
                              {
                                [y]=
                                x,
                                [Y]=
                                i,
                                [v]=
                                j,
                                [W]=
                                A,
                                [N]=
                                c,
                                [n]=
                                d,
                              }
                            d = false
                            k = M[k]
                            k = k(M,B)
                            B = "mXeiSKbb1DOh"
                            x = "Title"
                            Y = "Version"
                            f = nil
                            y = "rawset"
                            M = t(14033920,{V})
                            T[B] = M
                            B = "Title"
                            y = k[y]
                            j = I(1001984,{})
                            Et = "Handle"
                            y = y(k,x,Y)
                            M =
                              {
                                [B]=
                                y,
                              }
                            B = {}
                            A = "Title"
                            W = Z(16206336,{})
                            y = U()
                            Tt = "Character"
                            x = t(10003968,{y})
                            w[y] = B
                            B = {}
                            Y = "pcall"
                            B[Y] = x
                            P = "Handle"
                            x = H(12590080,{y})
                            Y = "task"
                            B[Y] = x
                            Y = "Web Designer"
                            x = S(9952256,{y})
                            B[Y] = x
                            X = true
                            n = "YgNM8kwDhVgj1"
                            x = nil
                            Y = U()
                            v = e(4151296,{m,Y})
                            w[Y] = x
                            x = U()
                            i = e(1712640,{m;Y})
                            w[x] = i
                            r = T["LocalPlayer"]
                            i = U()
                            N = "error"
                            Ct = t(13467136,{y;x})
                            w[i] = v
                            v = U()
                            w[v] = j
                            c = "CreateSlider"
                            j = U()
                            w[j] = W
                            W = M[A]
                            rt = I(12919808,{x;y;i})
                            A = "Notification"
                            A = W[A]
                            k = nil
                            A = A(W)
                            W = "CharacterAdded"
                            Y = l(Y)
                            J =
                              {
                                [Tt]=
                                X,
                              }
                            W = A[W]
                            W = W(A,N)
                            N = "pcall"
                            N = B[N]
                            Tt = "Character"
                            X = true
                            N = N(B,W,c,n,d,J)
                            n = Z(12910080,{y;p,K})
                            K = l(K)
                            Q = nil
                            c = "Flazhy and Huyz"
                            J =
                              {
                                [Tt]=
                                X,
                              }
                            d = false
                            Tt = "Character"
                            N = T[c]
                            c = N(n)
                            c = "ValueBase"
                            n = "table"
                            N = "pcall"
                            X = true
                            N = B[N]
                            N = N(B,W,c,n,d,J)
                            c = "Flazhy and Huyz"
                            n = e(13215744,{y;O,v,m;j})
                            N = T[c]
                            M = nil
                            d = false
                            c = N(n)
                            V = l(V)
                            c = "Theme"
                            A = nil
                            J =
                              {
                                [Tt]=
                                X,
                                [P]=
                                rt,
                              }
                            n = "v.Premium"
                            N = "pcall"
                            rt = true
                            v = l(v)
                            m = l(m)
                            N = B[N]
                            N = N(B,W,c,n,d,J)
                            c = "global"
                            J = 100
                            d = 1
                            P = "Character"
                            j = l(j)
                            n = "ipairs"
                            p = l(p)
                            x = l(x)
                            X =
                              {
                                [P]=
                                rt,
                                [Et]=
                                Ct,
                              }
                            y = l(y)
                            N = "Web Designer"
                            Tt = 1
                            N = B[N]
                            N = N(B,W,c,n,d,J,Tt,X)
                            N = "PrimaryPart"
                            n = a(1807872,{L})
                            L = l(L)
                            O = l(O)
                            i = l(i)
                            c = "addDropdown"
                            N = W[N]
                            N = N(W,c,n)
                            B = nil
                            W = nil
                          end
                        end
                      else
                        if r<11313188 then
                          if r<11130489 then
                            if r<10960357 then
                              p = w[K]
                              q = p
                              r = 5174272
                            else
                              f = w[D[2]]
                              q = f
                              r = 15238144
                            end
                          else
                            L = K
                            k = "BoolValue"
                            V = Q[k]
                            M = b[V]
                            r = not M
                            r = r and 13020160 or 15993344
                          end
                        else
                          if r<11368116 then
                            if r<11351551 then
                              L = "HumanoidRootPart"
                              L = K[L]
                              Q = "Value"
                              L = L(K,Q)
                              r = 3745792
                              p = L
                            else
                              r = 8478720
                            end
                          else
                            V = r
                            B = "workspace"
                            k = T[B]
                            r = k and 5158400 or 15489024
                            M = k
                          end
                        end
                      end
                    end
                  else
                    if r<12915699 then
                      if r<12578703 then
                        if r<12362534 then
                          if r<11691638 then
                            if r<11606954 then
                              A = "CreateToggle"
                              W = T[A]
                              j = r
                              r = W and 2809856 or 8492032
                              v = W
                            else
                              f, p = m(O,f)
                              r = f and 6021632 or 4349952
                            end
                          else
                            if r<12118566 then
                              K, Q = p(m,K)
                              r = K and 11233792 or 7061504
                            else
                              R = "GetChildren"
                              v = "GetDescendants"
                              r = T[R]
                              i = T[v]
                              R = r(i)
                              r = "si9T1NdNjRvyl"
                              T[r] = R
                              r = 732672
                            end
                          end
                        else
                          if r<12469772 then
                            if r<12426358 then
                              q = {}
                              r = T["Auto Chop Trees"]
                            else
                              r = 15175680
                            end
                          else
                            r = i
                            y = Y
                            r = 2379264
                          end
                        end
                      else
                        if r<12770722 then
                          if r<12652479 then
                            if r<12639047 then
                              O = C[2]
                              L = U()
                              b = C[1]
                              f = C[3]
                              Q = C[8]
                              m = U()
                              K = C[5]
                              p = C[6]
                              w[m] = C[4]
                              w[L] = C[7]
                              M = w[L]
                              q = M
                              r = M and 3416576 or 9235456
                            else
                              O = w[D[2]]
                              f = w[D[3]]
                              r = 14546432
                              b = O==f
                              q = b
                            end
                          else
                            O = m
                            r = K
                            r = m and 5471744 or 9728
                          end
                        else
                          if r<12906701 then
                            if r<12896001 then
                              r = w[D[2]]
                              q = w[D[3]]
                              K = "Handle"
                              O = b
                              r[q] = O
                              O = "HttpGet"
                              q = T[O]
                              m = w[D[1]]
                              f = m[K]
                              O = q(f)
                              q = "game"
                              r = O==q
                              r = r and 6493696 or 14713856
                            else
                              v = not i
                              F = F+R
                              q = F<=z
                              q = v and q
                              v = F>=z
                              v = i and v
                              q = v or q
                              v = 781824
                              r = q and v
                              q = 2397184
                              r = r or q
                            end
                          else
                            r = {}
                            b = r
                            r = 10000
                            O = r
                            r = 10077696
                          end
                        end
                      end
                    else
                      if r<13513331 then
                        if r<13243732 then
                          if r<13186665 then
                            if r<13002481 then
                              b = C[1]
                              r = b and 7233024 or 16083968
                            else
                              V = "spawn"
                              M = T[V]
                              V = "locked"
                              r = M[V]
                              k = "BoolValue"
                              V = Q[k]
                              M = r(f,V)
                              r = 15993344
                            end
                          else
                            if r<13223827 then
                              r = 3290624
                            else
                              r = w[D[2]]
                              q = w[D[3]]
                              O = b
                              r[q] = O
                              r = 12877824
                            end
                          end
                        else
                          if r<13485366 then
                            if r<13430798 then
                              r = T["Unlock All Gamepasses"]
                              q = {}
                              b = nil
                            else
                              O = "v.Premium"
                              b = C[1]
                              q = w[D[1]]
                              r = q[O]
                              r = r and 16388096 or 13404672
                            end
                          else
                            p = nil
                            r = 4447232
                          end
                        end
                      else
                        if r<13636681 then
                          if r<13587627 then
                            if r<13544670 then
                              r = {}
                              b = r
                              p = "CreateWindow"
                              K = T[p]
                              p = "Home"
                              m = K[p]
                              p = 1
                              r = 3548160
                              K = m(p)
                            else
                              r = w[D[10]]
                              O = w[D[11]]
                              b[r] = O
                              r = w[D[12]]
                              O =
                                {
                                  r(b),
                                }
                              q =
                                {
                                  E(O),
                                }
                              r = T["math"]
                            end
                          else
                            m = O
                            Q = "new"
                            L = "HumanoidRootPart"
                            L = K[L]
                            L = L(K,Q)
                            p = L
                            r = L and 3745792 or 11346432
                          end
                        else
                          if r<13679731 then
                            if r<13671529 then
                              q = "si9T1NdNjRvyl"
                              b = "GetDescendants"
                              r = T[q]
                              q = T[b]
                              b = "GetDescendants"
                              T[b] = r
                              b = "si9T1NdNjRvyl"
                              r = 8478720
                              T[b] = q
                              b = w[D[1]]
                              O = b()
                            else
                              M = "CudalPH"
                              Q = T[M]
                              V = "tostring"
                              M = "GamepassFolder"
                              M = Q[M]
                              M = M(Q,V)
                              r = 10852352
                              p = M
                            end
                          else
                            O = "q2qu7QgD08eZ4i"
                            f = 11668481
                            b = O^f
                            q = 13907457
                            r = q-b
                            q = "BHcF1cLGlOyU"
                            b = r
                            r = q/b
                            q =
                              {
                                r,
                              }
                            r = T["Main Farm"]
                          end
                        end
                      end
                    end
                  end
                else
                  if r<15500609 then
                    if r<14868037 then
                      if r<14371863 then
                        if r<14062023 then
                          if r<13997513 then
                            if r<13892295 then
                              Tt = 2
                              J = n[Tt]
                              r = 10659840
                              Tt = w[c]
                              d = J==Tt
                              st = d
                            else
                              r = w[D[1]]
                              Q = K
                              L = w[m]
                              r[L] = Q
                              r = 3621888
                            end
                          else
                            if r<14032557 then
                              q = "Enable Resize Weapon"
                              L = "Parent"
                              p = T[L]
                              L = "Model"
                              K = p[L]
                              p = K(b,b,b)
                              r = 2504704
                              m[q] = p
                            else
                              O = C[2]
                              K = "Size"
                              p = "loadstring"
                              b = C[1]
                              f = C[3]
                              m = "callback"
                              q = w[D[1]]
                              M = 5
                              r = q[m]
                              Q = r
                              L = f or M
                              m =
                                {
                                  [K]=
                                  b,
                                  [p]=
                                  O,
                                }
                              p = "Weapon Size"
                              q = "warn"
                              b = nil
                              O = nil
                              K =
                                {
                                  [p]=
                                  L,
                                }
                              q = r[q]
                              f = nil
                              q = q(r,m,K)
                              r = T["stop skidding - flazhy"]
                              q = {}
                            end
                          end
                        else
                          if r<14294315 then
                            if r<14228870 then
                              m = U()
                              L = "damage"
                              O = U()
                              b = C
                              K = U()
                              r = true
                              Q = h(10629632,{K})
                              w[O] = r
                              f = "FindFirstChild"
                              q = T[f]
                              f = "ClassName"
                              r = q[f]
                              f = U()
                              w[f] = r
                              r = e(16265728,{})
                              w[m] = r
                              r = false
                              w[K] = r
                              p = T[L]
                              L = p(Q)
                              q = L
                              r = L and 10903552 or 5174272
                            else
                              r = w[D[7]]
                              r = r and 2468864 or 7571968
                            end
                          else
                            m = O
                            q = K
                            p = r
                            r = K and 309760 or 16769024
                          end
                        end
                      else
                        if r<14525971 then
                          if r<14430158 then
                            if r<14396474 then
                              q = "zTkRpxHwtwuqS"
                              r = T[q]
                              b = w[D[1]]
                              q = r(b)
                              b = "CreateWindow"
                              q = T[b]
                              b = "Home"
                              r = q[b]
                              b = .05
                              q = r(b)
                              q = "zTkRpxHwtwuqS"
                              r = T[q]
                              b = w[D[1]]
                              q = r(b)
                              r = T["BasePart"]
                              q = {}
                            else
                              O, K = f(b,O)
                              r = O and 13587968 or 3803648
                            end
                          else
                            st = w[O]
                            q = st
                            r = st and 10249728 or 16302592
                          end
                        else
                          if r<14750878 then
                            if r<14587788 then
                              r = q and 14927872 or 14241792
                            else
                              b = nil
                              q = {}
                              r = T["FireServer"]
                            end
                          else
                            k = "IsA"
                            L = r
                            M = r
                            V = T[k]
                            Q = V
                            r = V and 7125504 or 8466432
                          end
                        end
                      end
                    else
                      if r<15219301 then
                        if r<15102048 then
                          if r<15029652 then
                            if r<14949626 then
                              q = "TreesFolder"
                              r = T[q]
                              m = "GetChildren"
                              Q = "damage"
                              b = w[D[4]]
                              f = T[m]
                              M = o(7747584,{})
                              L = T[Q]
                              Q =
                                {
                                  L(M),
                                }
                              p =
                                {
                                  E(Q),
                                }
                              L = 2
                              K = p[L]
                              m = f(K)
                              f = "LyOlTGYV"
                              O = b(m,f)
                              b =
                                {
                                  O(),
                                }
                              q = r(E(b))
                              O = w[D[5]]
                              b = q
                              q = O
                              r = O and 15114752 or 15699456
                            else
                              O = w[D[2]]
                              r = "iuwJ1iwCouC0xM"
                              q = "AutoCollectChest"
                              r = b[r]
                              r = r(b,q,O)
                              r = 337920
                            end
                          else
                            if r<15054614 then
                              q = w[D[2]]
                              r = not q
                              r = r and 619520 or 14030336
                            else
                              M = k
                              r = B
                              r = 15489024
                            end
                          end
                        else
                          if r<15147087 then
                            if r<15110886 then
                              r = 8965120
                              m = w[D[2]]
                              q = m
                            else
                              f = w[D[6]]
                              r = 15699456
                              O = f==b
                              q = O
                            end
                          else
                            r = 3290624
                          end
                        end
                      else
                        if r<15286657 then
                          if r<15240407 then
                            if r<15222993 then
                              O = "23LFGB6M4KON"
                              q = b[O]
                              O = "ReplicatedStorage"
                              r = q[O]
                              q =
                                {
                                  r,
                                }
                              r = T["type"]
                            else
                              r = q and 2406912 or 8863232
                            end
                          else
                            r = 16726016
                          end
                        else
                          if r<15481924 then
                            if r<15440066 then
                              w[O] = st
                              X = 1
                              Tt = w[A]
                              J = Tt+X
                              d = n[J]
                              G = k+d
                              d = 256
                              r = G%d
                              k = r
                              J = w[W]
                              d = B+J
                              r = 526848
                              J = 256
                              G = d%J
                              B = G
                            else
                              q = "kLdN5LLo4q"
                              r = T[q]
                              f = "ChestFolder"
                              q = w[D[2]]
                              f = q[f]
                              f =
                                {
                                  f(q),
                                }
                              O = f[2]
                              b = f[1]
                              f = r
                              r = 4975616
                            end
                          else
                            r = V
                            Q = not M
                            p = Q
                            r = 9080832
                          end
                        end
                      end
                    end
                  else
                    if r<16270654 then
                      if r<15797201 then
                        if r<15658641 then
                          if r<15592323 then
                            if r<15571818 then
                              K = "Handle"
                              O = "HttpGet"
                              q = T[O]
                              m = w[D[1]]
                              f = m[K]
                              O = q(f)
                              q = "game"
                              r = O==q
                              r = r and 10445312 or 289280
                            else
                              K = L
                              V = f[K]
                              y = "spawn"
                              r = 5811712
                              B = T[y]
                              y = "locked"
                              k = B[y]
                              B = k(m,V)
                              K = nil
                              k = true
                              b[V] = k
                              V = nil
                            end
                          else
                            if r<15654775 then
                              O = f
                              M = 255
                              r = w[D[1]]
                              Q = 0
                              L = r(Q,M)
                              b[O] = L
                              r = 8774656
                              O = nil
                            else
                              q = "23LFGB6M4KON"
                              r = b[q]
                              r = r and 15220736 or 9992704
                            end
                          end
                        else
                          if r<15746423 then
                            if r<15698624 then
                              b = nil
                              q = {}
                              r = T["AddTab"]
                            else
                              b = nil
                              r = 14241792
                              w[D[5]] = q
                            end
                          else
                            w[Q] = q
                            M = w[Q]
                            V = "Character"
                            r = M[V]
                            r = r and 3723264 or 832000
                          end
                        end
                      else
                        if r<16002319 then
                          if r<15993007 then
                            if r<15935503 then
                              Q = "Character"
                              w[p] = q
                              L = w[p]
                              r = L[Q]
                              r = r and 13982720 or 3621888
                            else
                              Q, M = p(L,Q)
                              r = Q and 6348288 or 6435328
                            end
                          else
                            L = nil
                            Q = nil
                            r = 12103680
                          end
                        else
                          if r<16214293 then
                            if r<16116551 then
                              q = w[D[3]]
                              r = 9288192
                              O = q()
                            else
                              q = "Util/Library.lua"
                              b = C[1]
                              K = "Name"
                              K = b[K]
                              r = T[q]
                              m =
                                {
                                  K(b),
                                }
                              K =
                                {
                                  r(E(m)),
                                }
                              q = K[1]
                              f = K[3]
                              m = q
                              O = K[2]
                              r = 11637248
                            end
                          else
                            b = "04s397cRDxrzM"
                            q = "IIOQQyfKWVnWZ"
                            r = T[q]
                            q = r(b)
                            r = T["eWd1zIuCJ51uH3"]
                            q = {}
                          end
                        end
                      end
                    else
                      if r<16372236 then
                        if r<16289399 then
                          if r<16280187 then
                            if r<16272290 then
                              q = M
                              r = V
                              r = M and 5735424 or 6349824
                            else
                              q = w[D[1]]
                              b = "table"
                              r = q[b]
                              r = r and 15442432 or 15175680
                            end
                          else
                            M = l(M)
                            Y = l(Y)
                            y = nil
                            x = nil
                            m = l(m)
                            f = l(f)
                            K = l(K)
                            Q = nil
                            k = nil
                            p = nil
                            O = l(O)
                            V = l(V)
                            Q = "CudalPH"
                            L = l(L)
                            f = r
                            L = T[Q]
                            K = r
                            p = not L
                            m = p
                            r = p and 10156032 or 12722176
                            B = nil
                          end
                        else
                          if r<16351705 then
                            if r<16294908 then
                              m = "CreateWindow"
                              f = T[m]
                              m = "Home"
                              O = f[m]
                              f = O()
                              f = "__index"
                              O = T[f]
                              m = "Auto Collect Chest"
                              f = O(m)
                              O = false
                              r = O and 15284224 or 16292864
                            else
                              r = 526848
                              w[O] = q
                            end
                          else
                            q = "ReplicatedStorage"
                            r = O[q]
                            q =
                              {
                                r,
                              }
                            r = T["random"]
                          end
                        end
                      else
                        if r<16688149 then
                          if r<16679906 then
                            if r<16584410 then
                              r = w[D[2]]
                              q = r(b)
                              r = 13404672
                            else
                              O = w[D[1]]
                              m = 1
                              K = 2
                              f = O(m,K)
                              O = 1
                              b = f==O
                              r = b and 14546432 or 12651008
                              q = b
                            end
                          else
                            f = "wait"
                            O = w[D[1]]
                            b = O[f]
                            O = "addSlider"
                            O = b[O]
                            O = O(b)
                            r = 1997312
                            q = O
                          end
                        else
                          if r<16767413 then
                            if r<16705256 then
                              r = 16271872
                              y = "spawn"
                              B = T[y]
                              y = "7CMjGwyP0eH5Z"
                              k = B[y]
                              M = k
                            else
                              m = "home-quantum"
                              f = T[m]
                              m = f()
                              f = "Tree"
                              O = m[f]
                              r = O and 2288640 or 10895872
                            end
                          else
                            r = p
                            r = q and 7177728 or 4447232
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
            r = #g
            return
              E(q)
          end,
          function(T,s)
            local E = f(s)
            local C =
              function(C)
                return
                  r(T,{C},s,E)
              end
            return
              C
          end,
          function(T,s)
            local E = f(s)
            local C =
              function(C,D,g,u,q,w,b,U,O,f,m)
                return
                  r(T,{C,D;g,u,q;w,b,U,O,f,m},s,E)
              end
            return
              C
          end,
          function(T)
            local s, r = 1, T[1]
            while r do
              b[r], s = b[r]-1, 1+s
              if b[r]==0 then
                b[r], w[r] = nil, nil
              end
              r = T[s]
            end
          end,
          {},
          function()
            O = 1+O
            b[O] = 1
            return
              O
          end,
          function(T,s)
            local E = f(s)
            local C =
              function(C,D,g,u)
                return
                  r(T,{C,D,g,u},s,E)
              end
            return
              C
          end,
          function(T,s)
            local E = f(s)
            local C =
              function()
                return
                  r(T,{},s,E)
              end
            return
              C
          end,
          function(T,s)
            local E = f(s)
            local C =
              function(C,D)
                return
                  r(T,{C,D},s,E)
              end
            return
              C
          end,
          0,
          {},
          function(T,s)
            local E = f(s)
            local C =
              function(C,D,g,u,q,w)
                return
                  r(T,{C,D;g;u;q,w},s,E)
              end
            return
              C
          end,
          function(T,s)
            local E = f(s)
            local C =
              function(C,D,g)
                return
                  r(T,{C;D;g},s,E)
              end
            return
              C
          end,
          function(T,s)
            local E = f(s)
            local C =
              function(C,D,g,u,q)
                return
                  r(T,{C,D;g;u;q},s,E)
              end
            return
              C
          end
        return
          (K(14156800,{}))(E(q))
      end)
      (
        getfenv and getfenv()or _ENV,
        unpack or table["7CMjGwyP0eH5Z"],
        newproxy,
        setmetatable,
        getmetatable,
        select,
        {
          ...,
        }
      )
  end)
  (
    ...
  )
