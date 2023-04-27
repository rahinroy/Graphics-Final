// Uses depth information and adjacent pixels to find the normal of each face 
void main()
{
	float epsilon = 0.001;
	float2 pos = GetCoordinates();

	float depth_p0 = SampleDepthLocation(pos);
	
	float2 p1_xy = float2(pos.x + GetInvResolution().x, pos.y);
	float depth_p1 = SampleDepthLocation(p1_xy);

	float2 p2_xy = float2(pos.x, pos.y + GetInvResolution().y);
	float depth_p2 = SampleDepthLocation(p2_xy);


	float3 p0 = float3(pos, depth_p0);
	float3 p1 = float3(p1_xy, depth_p1);
	float3 p2 = float3(p2_xy, depth_p2);

	float3 v1 = p1 - p0;
	float3 v2 = p2 - p0;
	float3 normal = normalize(cross(v1, v2));
	normal.z *= -1.0;

	float3 camera_pos = float3(0.5, 0.5, 0);
	float3 camera_ray = normalize(camera_pos - p0);
	float cos_angle = dot(camera_ray, normal);
	
	float4 c0 = Sample();

	float factor = 5;
    float red    = (floor(c0.r * factor) / factor);
    float green  = (floor(c0.g * factor) / factor);
    float blue   = (floor(c0.b * factor) / factor);

	if (depth_p0 > 1 - epsilon){
		SetOutput(float4(0.2, 0.2, 0.2, 0.0));
	} else {
		normal.z = 0;
		SetOutput(float4(abs(normal), c0.a));
	}


}