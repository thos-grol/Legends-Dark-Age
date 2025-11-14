chunk = 27
chunk_store_max = 200

num_squads = 10

start = 0
end = 0
for i in range(num_squads + 1):
    if i == 0: 
        end = chunk-1
    else:
        start += 27
        end += 27
    print(f'{start} : {end}')
    
print(f'{end + 1} : {end + 1 + chunk_store_max}')
