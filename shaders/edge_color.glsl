// highlight edges based on color diff

void main()
{
    float4 c0 = Sample();
    float4 depth = Sample();
    bool onEdge = false;
    float THRESHOLD = 0.5;

    float4 offset_depths[8] = float4[](
        SampleOffset(int2(0, 1)),
        SampleOffset(int2(0, -1)),
        SampleOffset(int2(1, 0)),
        SampleOffset(int2(-1, 0)),
        SampleOffset(int2(1, 1)),
        SampleOffset(int2(-1, 1)),
        SampleOffset(int2(1, -1)),
        SampleOffset(int2(-1, -1))
    );


    for (int x = 0; x <= offset_depths.length(); x++){
        if (length(depth - offset_depths[x]) > THRESHOLD){
            onEdge = true;
        }
    }

    if (onEdge){
        SetOutput(float4(1, 1, 1, 1.0));
    } else{
        SetOutput(float4(0, 0, 0, 1.0));
    }
}
